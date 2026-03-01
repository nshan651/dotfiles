(define-module (ns packages emacs)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages emacs-build)
  #:use-module (gnu packages version-control)
  #:use-module (nongnu packages emacs)
  #:export (emacs-packages))

(define emacs-packages
  (list
   ;; Package management.
   emacs-use-package

   ;; Themes.
   emacs-doom-themes
   emacs-ef-themes
   emacs-org-bullets
   emacs-perspective
   emacs-modus-themes

   ;; Evil / Keybindings.
   emacs-evil
   emacs-evil-org
   emacs-evil-collection
   emacs-general
   emacs-evil-nerd-commenter
   emacs-hydra

   ;; UX.
   emacs-ws-butler
   emacs-undo-fu
   emacs-undo-fu-session
   emacs-vertico
   emacs-corfu
   emacs-kind-icon
   emacs-orderless
   emacs-consult
   emacs-marginalia
   emacs-embark
   emacs-helpful
   emacs-counsel

   ;; UI extensions.
   emacs-consult-org-roam
   emacs-popper

   ;; Development.
   emacs-dap-mode
   emacs-projectile
   emacs-dash

   ;; Programming Languages/LSP.
   emacs-yaml-mode
   emacs-ccls
   emacs-rust-mode

   ;; Latex
   emacs-latex-preview-pane

   ;; Misc.
   emacs-default-text-scale
   emacs-xclip
   emacs-avy
   emacs-ace-window
   emacs-websocket

   ;; UI
   emacs-visual-fill-column
   emacs-org-appear
   emacs-nerd-icons
   emacs-doom-modeline

   ;; Compatibility with newer Emacs versions.
   emacs-compat

   ;; Org.
   emacs-org
   emacs-org-journal
   emacs-org-pomodoro
   emacs-org-roam
   emacs-org-roam-ui
   emacs-org-ql
   emacs-htmlize
   emacs-logos
   emacs-org-drill

   ;; Sqlite3 dependency for org roam.
   emacs-sqlite3-api
   emacs-emacsql

   ;; Web.
   emacs-ox-hugo

   ;; Applications
   emacs-org-caldav
   emacs-org-present

   ;; Version control.
   emacs-magit
   emacs-magit-todos
   emacs-forge
   emacs-git-link
   emacs-git-gutter
   emacs-git-gutter-fringe

   ;; Programming Languages.
   emacs-geiser

   emacs-markdown-mode

   emacs-yasnippet
   emacs-yasnippet-snippets

   emacs-smartparens
   emacs-rainbow-delimiters
   emacs-rainbow-mode
   emacs-posframe

   emacs-a
   emacs-request

   ;; AI.
   emacs-gptel

   ;; Shell.
   emacs-eat
   emacs-esh-autosuggest
   emacs-xterm-color
   emacs-exec-path-from-shell
   emacs-pcmpl-args
   emacs-eshell-syntax-highlighting
   emacs-vterm

   ;; Applications.
   emacs-elfeed

   emacs-guix

   emacs-docker
   emacs-dockerfile-mode
   ))
