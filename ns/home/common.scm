(define-module (ns home common)
  #:use-module (ns home desktop)
  #:use-module (ns home emacs)
  #:use-module (gnu services)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services pm)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services mcron)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services syncthing)
  #:use-module (guix gexp))

(define-public common-home-services
  (list
   ;; Set environment variables for every session
   (simple-service 'profile-env-vars-service
                   home-environment-variables-service-type
                   '(
                     ;; Sort hidden (dot) files first in `ls` listings.
                     ("LC_COLLATE" . "C")

                     ;; Set the editor.
                     ("VISUAL" . "vim")
                     ("EDITOR" . "vim")

                     ;; Add some things to $PATH.
                     ("PATH" . "$HOME/.local/bin:$HOME/.npm-global/bin:$PATH")

                     ;; Make sure Flatpak apps a.re visible
                     ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share")

                     ;; Set Wayland-specific environment variables.
                     ("XDG_CURRENT_DESKTOP" . "sway")
                     ;; ("XDG_CURRENT_DESKTOP" . "hyprland")
                     ("XDG_SESSION_TYPE" . "wayland")
                     ("RTC_USE_PIPEWIRE" . "true")
                     ("SDL_VIDEODRIVER" . "wayland")
                     ("MOZ_ENABLE_WAYLAND" . "1")
                     ("CLUTTER_BACKEND" . "wayland")
                     ("ELM_ENGINE" . "wayland_egl")
                     ("ECORE_EVAS_ENGINE" . "wayland-egl")
                     ("QT_QPA_PLATFORM" . "wayland-egl")))

   ;; Set up the shell environment
   (service home-zsh-service-type
            (home-zsh-configuration
             (zprofile
	          `(,(local-file "../files/profile")))
             (zshrc
              `(,(local-file "../files/zshrc")))))

   ;; Load inputrc.
   (simple-service 'profile-files-service
                   home-files-service-type
                   (list `(".inputrc" ,(local-file "../files/inputrc"))))

   ;; GnuPG configuration.
   (service home-gpg-agent-service-type
            (home-gpg-agent-configuration
             (ssh-support? #t)
             (default-cache-ttl 28800)
             (max-cache-ttl 28800)
             (default-cache-ttl-ssh 28800)
             (max-cache-ttl-ssh 28800)))

   ;; Emacs configuration
   (service home-emacs-config-service-type)

   ;; Run user dbus session.
   (service home-dbus-service-type)

   ;; Set up desktop environment
   (service home-desktop-service-type)

   ;; File synchronization
   (service home-syncthing-service-type)

   ;; Monitor battery levels
   ;; (service home-batsignal-service-type)

   ;; Udiskie for auto-mounting devices
   ;; (service home-udiskie-service-type)
   ))
