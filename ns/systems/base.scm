(define-module (ns systems base)
  #:use-module (srfi srfi-1)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system nss)
  #:use-module (gnu system setuid)
  #:use-module (gnu system privilege)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu packages video)
  #:use-module (nongnu system linux-initrd))

(use-service-modules
 dns guix admin sysctl pm nix avahi dbus cups desktop linux
 mcron networking xorg ssh docker audio virtualization)

(use-package-modules
 audio video nfs certs shells ssh linux bash emacs gnome networking wm fonts
 libusb cups freedesktop file-systems version-control package-management
 pciutils vim xorg)

(define-public base-system
  (operating-system
   (timezone "America/Chicago")
   (locale "en_US.utf8")

   ;; Use non-free Linux and firmware
   (kernel linux)
   (firmware (list linux-firmware))
   (initrd microcode-initrd)

   (host-name "base-system")
   (keyboard-layout (keyboard-layout "us"))

   ;; Prevent 'pcspkr' from loading twice.
   (kernel-arguments
    (append
     (list "modprobe.blacklist=pcspkr,bluetooth,btusb" ; Blacklist pcspkr
	   "bluetooth.disable_ertm=1") %default-kernel-arguments))

   ;; The bootloader will be overwritten.
   (bootloader (bootloader-configuration
		(bootloader grub-bootloader)
		(targets '("/dev/sda"))
		(keyboard-layout keyboard-layout)))

   ;; Add a tmpfs.
   (file-systems (cons*
                  (file-system
                   (mount-point "/tmp")
                   (device "none")
                   (type "tmpfs")
                   (check? #f))
                  %base-file-systems))

   (users (cons (user-account
                 (name "nick")
                 (comment "nick")
		         (shell #~(string-append #$zsh "/bin/zsh"))
                 (group "users")
                 (supplementary-groups '("wheel"
					                     "netdev"
                                         "kvm"
					                     "keyd"
                                         "tty"
                                         "input"
                                         "docker"
					                     "lp"
                                         "audio"
					                     "video")))
                %base-user-accounts))

   ;; Add the 'keyd' group
   (groups (cons (user-group (system? #t) (name "keyd"))
                 %base-groups))

   ;; Install basic system packages.
   (packages (cons*
	      brightnessctl
	      exfat-utils
	      fuse-exfat
	      git
	      gvfs
	      libpciaccess
	      pciutils
	      stow
	      vim
          util-linux
	      zsh
	      %base-packages))

   (services
    (cons*
     ;; Seat management.
     (service elogind-service-type)

     ;; Configure swaylock as a setuid program
     (service screen-locker-service-type
              (screen-locker-configuration
               (name "swaylock")
               (program (file-append swaylock "/bin/swaylock"))
               (using-pam? #t)
               (using-setuid? #f)))

     ;; Configure the Guix service and ensure we use Nonguix substitutes
     (simple-service 'add-nonguix-substitutes
                     guix-service-type
                     (guix-extension
                      (substitute-urls
                       (append (list "https://substitutes.nonguix.org")
                               %default-substitute-urls))
                      (authorized-keys
                       (append (list (plain-file "nonguix.pub"
                                                 "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                               %default-authorized-guix-keys))))

     ;; Set up Polkit to allow `wheel' users to run admin tasks
     polkit-wheel-service

     ;; Networking services.
     (service network-manager-service-type)
     (service wpa-supplicant-service-type)

     ;; Basic desktop services.
     (service udisks-service-type)
     (service upower-service-type)
     (service cups-pk-helper-service-type)
     (service geoclue-service-type)
     (service polkit-service-type)
     (service dbus-root-service-type)
     fontconfig-file-system-service ;; Manage the fontconfig cache

     ;; Power and thermal management services
     (service thermald-service-type)
     (service tlp-service-type
              (tlp-configuration
               (cpu-boost-on-ac? #t)
               (wifi-pwr-on-bat? #t)))

     ;; Enable Docker containers and virtual machines
     (service containerd-service-type)
     (service docker-service-type)
     (service libvirt-service-type
              (libvirt-configuration
               (unix-sock-group "libvirt")
               (tls-port "16555")))

     ;; Enable SSH access.
     (service openssh-service-type)

     ;; Enable printing.
     (service cups-service-type
              (cups-configuration
               (web-interface? #t)
               (extensions
                (list cups-filters))))

     ;; Set up the X11 socket directory for XWayland
     (service x11-socket-directory-service-type)

     ;; Sync system clock with time servers
     (service ntp-service-type)

     ;; Add udev rules for a few packages
     (udev-rules-service 'pipewire-add-udev-rules pipewire)
     (udev-rules-service 'brightnessctl-udev-rules brightnessctl)

     ;; Enable the build service for Nix package manager
     (service nix-service-type)

     ;; Schedule cron jobs for system tasks
     (simple-service 'system-cron-jobs
                     mcron-service-type
                     (list
                      ;; Run `guix gc' 5 minutes after midnight every day.
                      ;; Clean up generations older than 2 months and free
                      ;; at least 10G of space.
                      #~(job "5 0 * * *" "guix gc -d 2m -F 10G")))

     ;; Use base-services.
     %base-services))))
