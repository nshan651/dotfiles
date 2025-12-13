;;; Install this manifest file on a foreign distro with
;;; `guix package -m emacs.scm' to let guix package your emacs.
(use-modules (guix packages)
             (guix gexp)
             (gnu packages)
             (gnu packages emacs)
             (gnu packages emacs-build)
             (gnu packages emacs-xyz)
             (gnu packages gcc)
             (gnu packages version-control)
             (gnu packages curl)
             (gnu packages cpp)
             (gnu packages rust)
             (gnu packages tree-sitter)
             (gnu packages fonts)
             (gnu packages fontutils)
             (gnu packages tls)
             (gnu packages sqlite)
             (nongnu packages emacs))

(packages->manifest
 (list
  ;; System-level deps.
  curl
  sqlite
  gnutls

  ;; Language servers.
  ccls
  rust-analyzer

  ;; Fonts.
  font-abattis-cantarell
  font-awesome
  font-fira-code
  font-fira-mono
  fontmanager

  ;; Emacs itself.
  emacs

  ;; Package management.
  emacs-use-package

  ;; Themes.
  emacs-doom-themes
  emacs-ef-themes
  emacs-org-bullets
  emacs-perspective

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
  emacs-org-make-toc
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

  emacs-orgalist
  emacs-markdown-mode

  emacs-popper
  emacs-modus-themes

  ;; emacs-web-mode
  ;; emacs-skewer-mode

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

  ;; TODO: Move to mail profile
  emacs-eat
  emacs-esh-autosuggest
  emacs-xterm-color
  emacs-exec-path-from-shell

  emacs-pcmpl-args

  emacs-eshell-syntax-highlighting
  emacs-vterm

  emacs-elfeed

  emacs-guix

  emacs-docker
  emacs-dockerfile-mode
  ))
