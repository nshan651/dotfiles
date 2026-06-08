;; guix system vm -L ~/git/channel-5 wayland.scm \
;;   -r ./wayland \
;;   --share=$HOME/git/dwl=/home/test/git/dwl
;; ./wayland -nic user,hostfwd=tcp::2222-:22
(use-modules
 (gnu)
 (gnu system)
 (gnu services)
 (gnu home)
 (gnu home services)
 (gnu home services shells)
 (guix gexp))

(use-service-modules avahi dns desktop guix linux networking ssh xorg)
(use-package-modules base certs commencement fonts freedesktop pkg-config
                     terminals shells version-control vim wm xorg)

(define vm-common
  (home-environment
   (services
    (list
     ;; Set environment variables for every session
     (simple-service
      'profile-env-vars-service
      home-environment-variables-service-type
      '(
        ;; Sort hidden (dot) files first in `ls` listings.
        ("LC_COLLATE" . "C")

        ;; Set the editor.
        ("VISUAL" . "vim")
        ("EDITOR" . "vim")

        ;; Add some things to $PATH.
        ("PATH" . "$HOME/.local/bin:$HOME/.npm-global/bin:$PATH")

        ;; VM software rendering...
        ("WLR_RENDERER_ALLOW_SOFTWARE" . "1")

        ;; Make sure Flatpak apps a.re visible
        ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share")

        ;; Set Wayland-specific environment variables.
        ("XDG_CURRENT_DESKTOP" . "dwl")
        ;; ("XDG_CURRENT_DESKTOP" . "hyprland")
        ("XDG_SESSION_TYPE" . "wayland")
        ("RTC_USE_PIPEWIRE" . "true")
        ("SDL_VIDEODRIVER" . "wayland")
        ("MOZ_ENABLE_WAYLAND" . "1")
        ("CLUTTER_BACKEND" . "wayland")
        ("ELM_ENGINE" . "wayland_egl")
        ("ECORE_EVAS_ENGINE" . "wayland-egl")
        ("QT_QPA_PLATFORM" . "wayland-egl")))))))

(operating-system
 (host-name "wayland")
 (timezone "America/Chicago")
 (locale "en_US.utf8")

 (keyboard-layout (keyboard-layout "us"))

 (bootloader
  (bootloader-configuration
   (bootloader grub-bootloader)
   (targets '("/dev/vda"))
   (keyboard-layout keyboard-layout)))

 (file-systems
  (cons (file-system
         (mount-point "/")
         (device (file-system-label "my-root"))
         (type "ext4"))
        %base-file-systems))

 (users
  (cons (user-account
         (name "test")
         (group "users")
         (password (crypt "test" "$6$abc"))
         (home-directory "/home/test")
         (supplementary-groups '("wheel" "video" "tty" "input")))
        %base-user-accounts))

  (packages
   (cons*
    dwl

    ;; Basic tools.
    foot
    which
    vim
    git

    ;; Build tools and deps for compiling dwl from source.
    gcc-toolchain
    make
    pkg-config
    libinput
    wayland
    wayland-protocols
    wlroots
    libxkbcommon

    %base-packages))

 (services
   (cons*
    (service dhcpcd-service-type)
    (service elogind-service-type)
    (service avahi-service-type)
    (service openssh-service-type
             (openssh-configuration
              (permit-root-login #f)
              (password-authentication? #t)))
    (service guix-home-service-type
             `(("test" ,vm-common)))
   %base-services)))
