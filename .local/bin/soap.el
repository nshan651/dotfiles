#!/usr/bin/emacs --script
;;; (S)ync (O)ver (A)ll (P)rogress
;;; Sync all documents and git repos with remote devices.
;;;
;;; "Don't forget to use soap!"

(require 'cl-lib)

(defvar usage
  "usage: soap.el [-h] [-g] [-d]

  (S)ync (O)ver (A)ll (P)rogress
  Sync all documents and git repos with remote devices.

  options:
  -h, --help            Show this help message and exit.
  -g, --sync-git        Sync all git repositories listed in git_repos.
  -d, --sync-dox        Sync all documents in XDG_DOCUMENTS_DIR.")

(defmacro sh (&rest commands)
  "Evaluate multiple shell commands."
  `(progn
     ,@(mapcar (lambda (cmd) `(shell-command ,cmd)) commands)))

(defmacro sh-collect (&rest commands)
  "Evaluate multiple shell commands and collect them in a single string."
  `(concat
     ,@(mapcar (lambda (cmd) `(shell-command-to-string ,cmd)) commands)))

;;; === Configuration Settings ===

;; List of remote machines, based on the HostNames in your .ssh/config file.
(defvar machines
  '(
    ;; My main PC (disabled)
    ;; (arch . "/home/nick/sync")

    ;; Debian server
    (debox . "~/sync")

    ;; Raspberry Pi 4 (disabled)
    ;; (pibox . "/home/nick/sync")
    ))

;; Physical storage media
(defvar drives
  '(
    (ssd1 . "/media/ssd1/sync")
    (hdd1 . "/media/hdd1/sync")
    ))

(defun filter-dotdirs (files)
  "Filter out '.' and '..' from a list of files.
   Not sure why this isn't the default..."
  (cl-remove-if
   (lambda (path)
     (member (file-name-nondirectory path) '("." "..")))
   files))

(defun add-repo-dir (path)
  "Add a project directory to the git-repos path."
  (let ((files (filter-dotdirs (directory-files path)))
	(pathbase (file-name-nondirectory path)))
    (mapcar (lambda (f) (concat pathbase "/" f)) files)
))

(defvar git-repos
  (nconc
   ;; Add project directories here
   ;; TODO: Pull this out into a function for adding a dir
   ;; (directory-files "~/git" t)
   (add-repo-dir "~/git")

   ;; Add individual repos here
   '(
     ".local/opt/st"
     ".local/opt/dwm"
     ".local/opt/dwmblocks"
     ".emacs.d"
     "org"
     "dox/family-finance"
     "dox/personal-finance"
     "dox/pass"
     ))
   )

;; Source forges
(defvar source-forges
  '(
    (github . "https://github.com/nshan651")
    (gitlab . "https://gitlab.com/nshan651")
    (selfhost . "~/sync/git")
    ))

;;; === Function Declarations ===

(defun custom-git-commands (repo remote branch)
  "Define a series of git commands to be run in the shell."
  (cond

   ;; Dotfiles git command
   ((eq repo "git/dotfiles.git")
    (sh
     "config add ~/.config"
     "config add ~/.local/bin"
     (format "config commit -m 'Routine backup of %s'")
     (format "config push %s %s" remote branch)))

   ;; Default git command
   (t
    (sh
     "git add -A"
     (format "git commit -m 'Routine backup of %s'" repo-name)
     (format "git push %s %s" remote branch)))))

(defun print-update-msg (target)
  "Pretty-print an update message."
  ""
  (message (format
"\n┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  Uploading %s...
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
   target)))

(defun update-repo (repo)
  "Update a git repo."
  (setq repo-path repo
	repo-name (file-name-nondirectory repo))

  (cd (concat "~/" repo-path))

  (let ((branch (split-string (sh-collect "git branch --format='%(refname:short)'") "\n"))
	(remotes (split-string (sh-collect "git remote") "\n")))
    (dolist (remote remotes)

      (custom-git-commands repo-name remote branch)
    )
  )
  )

(defun sync-git ()
  "Sync all git repos."
  (let ((_machines (mapcar #'car machines)))
    (dolist (machine _machines)
      (dolist (repo git-repos)
	(print-update-msg repo)
	(update-repo repo)
	;; (message "REPO: %s MACHINE: %s" repo machine)
      ))
    )
  )

(sync-git)

(directory-files "~/git" t)

(defun sync-dox ()
  "Sync documents, located at XDG_DOCUMENTS_DIR by default."
  (let ((dir (getenv "XDG_DOCUMENTS_DIR"))
	(_machines (mapcar #'car machines)))
    (dolist (machine _machines)
      ;; (sh (format "rsync --exclude='*.git' --mkpath -aRiv '%s' '%s:/'" dir machine))
      (message "DIR: %s MACHINE: %s" dir machine)
      )))

