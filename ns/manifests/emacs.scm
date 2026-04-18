;;; Install this manifest file on a foreign distro with
;;; `guix package -L ~/.dotfiles -m ~/.dotfiles/ns/manifests/emacs.scm' to let guix package your emacs.
;;; Upgrade with `guix upgrade'
(use-modules  (ns packages emacs)
              (guix packages)
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
              (gnu packages machine-learning)
              (nongnu packages emacs))

(packages->manifest
 (append
  (list
   ;; System-level deps.
   curl
   sqlite
   gnutls
   git

   ;; Whisper backend
   whisper-cpp

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
   emacs)
  emacs-packages))
