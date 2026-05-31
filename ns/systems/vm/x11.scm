;; guix system image -L ~/git/channel-5 \
;;   --image-type=qcow2 x11.scm \
;;   -r ./x11.qcow2
;;
;; qemu-system-x86_64 \
;;   -m 2048 \
;;   -enable-kvm \
;;   -snapshot \
;;   -hda ./x11.qcow2
(use-modules (gnu)
             (gnu system)
             (gnu services)
             (gnu home services)
             (gnu home)
             (gnu services xorg)
             (gnu services networking)
             (gnu services dbus)
             (gnu packages xorg)
             (gnu packages wm)
             (gnu packages nss)
             (gnu packages fonts)
             (gnu packages vim)
             (gnu packages terminals)
             (gnu packages admin)
             (guix gexp)
             (gnu home services shells)
             (channel-5 packages dwm)
             (channel-5 packages st))

(use-service-modules desktop ssh guix)
(use-package-modules certs)

(define test-home
  (home-environment
   (services
    (list
     (simple-service 'my-xsession-service
                     home-files-service-type
                     `((".xsession"
                        ,(computed-file "xsession"
                                        #~(begin
                                            (with-output-to-file #$output
                                              (lambda ()
                                                (display "#!/bin/sh\n")
                                                ;; This bakes the exact /gnu/store/.../bin/dwm path into the file
                                                (display (string-append "exec " #$dwm "/bin/dwm\n"))))
                                            ;; Make the file executable so SLiM can run it
                                            (chmod #$output #o755))))))))))

(operating-system
 (host-name "x11")
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
         (supplementary-groups '("wheel" "video" "audio" "tty" "input")))
        %base-user-accounts))

 (packages
  (cons*
   ;; X11 packages
   xorg-server
   xinit
   xterm
   setxkbmap
   font-dejavu ; X needs at least one font.
   ;; Basic commands
   ;; coreutils
   ;; findutils
   ;; nss-certs ; in %base-packages
   which
   vim
   dwm
   st
   %base-packages))

 (services
  (cons*
   (service dhcpcd-service-type)
   (service guix-home-service-type
            `(("test" ,test-home)))

   (service slim-service-type
            (slim-configuration
             (auto-login? #t)
             (default-user "test")))
   %base-services)))
