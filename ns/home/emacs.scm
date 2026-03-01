(define-module (ns home emacs)
  #:use-module (ns packages emacs)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages emacs-build)
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
  emacs-packages)

(define home-emacs-config-service-type
  (service-type (name 'home-emacs-config)
                (description "Applies my personal Emacs configuration.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-emacs-config-profile-service)))
                (default-value #f)))
