;; guix system image -L ~/git/channel-5 \
;;   --image-type=qcow2 wayland.scm \
;;   -r ./wayland.qcow2
;;
;; qemu-system-x86_64 \
;;   -m 2048 \
;;   -enable-kvm \
;;   -snapshot \
;;   -hda ./wayland.qcow2
(use-modules
 (gnu)
 (gnu system)
 (gnu services)
 (gnu services base)
 (gnu services networking)
 (gnu packages gl)
 (gnu packages freedesktop)
 (gnu packages xorg)
 (gnu packages wm)
 (gnu packages vim)
 (gnu packages terminals)
 (gnu packages fonts)
 (gnu packages base)
 (gnu packages xdisorg))

(use-service-modules desktop)
(use-package-modules certs)

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
         (supplementary-groups '("wheel" "seat" "video" "tty" "input")))
        %base-user-accounts))

 (packages
  (cons*
   ;; Wayland compositor deps.
   mesa
   libdrm
   libinput
   libxkbcommon

   ;; Basic tools.
   foot
   which
   vim

   %base-packages))

 (services
  (cons*
   (service seatd-service-type)
   (service dhcpcd-service-type)
   (modify-services %base-services
     (agetty-service-type config =>
      (agetty-configuration
       (inherit config)
       (extra-options '("-a" "test"))))))))
