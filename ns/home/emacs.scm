(define-module (ns home emacs)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (gnu services configuration)
  #:use-module (guix gexp)
  #:use-module (guix transformations)
  #:use-module (nongnu packages emacs)
  #:export (home-emacs-config-service-type))

(define (home-emacs-config-profile-service config)
  (list

   ;; Themes.
   emacs-doom-themes
   emacs-ef-themes
   emacs-nerd-icons
   emacs-doom-modeline
   emacs-org-bullets
   emacs-perspective

   ;; Evil mode.
   emacs-evil
   emacs-evil-org
   emacs-evil-collection
   emacs-general
   emacs-evil-nerd-commenter
   emacs-ws-butler
   emacs-hydra
   
   ;; UI.
   emacs-undo-fu
   emacs-undo-fu-session
   emacs-which-key
   emacs-vertico
   emacs-corfu
   emacs-kind-icon
   emacs-orderless
   emacs-consult
   emacs-wgrep
   emacs-marginalia
   emacs-embark
   emacs-helpful

   emacs-counsel

   ;; Development.
   emacs-lsp-mode
   emacs-lsp-ui
   emacs-consult-lsp
   emacs-lsp-treemacs
   ;emacs-treesit-auto
   emacs-dap-mode
   emacs-company
   emacs-company-box
   emacs-projectile

   ;; Programming Languages/LSP.
   emacs-yaml-mode
   emacs-ccls
   ;emacs-python-mode
   ;emacs-go-mode
   ;emacs-rust-mode

   ;; Latex
   emacs-latex-preview-pane

   ;; Misc.
   emacs-default-text-scale
   emacs-xclip
   emacs-avy
   emacs-ace-window
   emacs-websocket

   ;; Visual fill
   emacs-visual-fill-column

   emacs-org-appear

   ;; Compatibility with newer Emacs versions.
   emacs-compat

   ;; Fonts.
   emacs-nerd-icons
   emacs-all-the-icons

   ;; Org.
   emacs-org
   emacs-org-modern
   emacs-org-pomodoro
   emacs-org-make-toc
   emacs-org-roam
   emacs-org-roam-ui
   emacs-org-ql
   emacs-htmlize
   emacs-logos

   ;; Sqlite3 dependency for org roam.
   emacs-sqlite3-api
   emacs-emacsql

   ;; Web.
   emacs-ox-hugo

   ;; Applications
   emacs-org-caldav

   ;; Version control.
   emacs-magit
   emacs-magit-todos
   emacs-forge
   emacs-git-link
   emacs-git-gutter
   emacs-git-gutter-fringe

   ;; Programming Languages.
   ;emacs-sly
   ;emacs-sly-asdf

   emacs-geiser

   emacs-orgalist
   emacs-markdown-mode

   emacs-web-mode
   emacs-skewer-mode


   emacs-flycheck

   emacs-yasnippet
   emacs-yasnippet-snippets

   emacs-smartparens

   emacs-rainbow-delimiters

   emacs-rainbow-mode

   emacs-posframe

   emacs-a
   emacs-request

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

   emacs-daemons

   emacs-docker
   emacs-dockerfile-mode
   ))

(define home-emacs-config-service-type
  (service-type (name 'home-emacs-config)
                (description "Applies my personal Emacs configuration.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-emacs-config-profile-service)))
                (default-value #f)))
