;;; A custom install image, donwload this as a qcow iso.
;;; guix system image -L ~/.dotfiles \
;;;   --cores=1 --max-jobs=1 \
;;;   --substitute-urls="https://ci.guix.gnu.org https://substitutes.nonguix.org" \
;;;   -t iso9660 installer.scm
;;;
;;; Test this in a guix vm with:
;;; guix system vm -L ~/.dotfiles \
;;;   --substitute-urls="https://ci.guix.gnu.org https://substitutes.nonguix.org" \
;;;   installer.scm
;;;
;;; Note: If running this on a foreign guix system, run 'sudo -i guix pull'
;;; sudo -i guix pull --channels=/home/nick/.config/guix/channels.scm
(define-module (ns systems installer)
  #:use-module (guix channels)
  #:use-module (gnu)
  #:use-module (gnu system install)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages cryptsetup)
  #:use-module (gnu packages vim)
  #:use-module (gnu services)
  #:use-module (gnu services networking)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

;; https://substitutes.nonguix.org/signing-key.pub
(define %signing-key
  (plain-file "nonguix.pub" "\
(public-key
 (ecc
  (curve Ed25519)
  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))

(define %channels-file
  (plain-file "channels.scm"
              "(list (channel
        (name 'guix)
        (url \"https://git.guix.gnu.org/guix.git\")
        (introduction
          (make-channel-introduction
            \"9edb3f66fd807b096b48283debdcddccfea34bad\"
            (openpgp-fingerprint
              \"BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA\"))))
      (channel
        (name 'nonguix)
        (url \"https://gitlab.com/nonguix/nonguix\")
        (introduction
          (make-channel-introduction
            \"897c1a470da759236cc11798f4e0a5f7d4d59fbc\"
            (openpgp-fingerprint
              \"2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5\")))))"))

(define %channels
  (cons* (channel
          (name 'nonguix)
          (url "https://gitlab.com/nonguix/nonguix")
          ;; Enable signature verification:
          (introduction
           (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
         %default-channels))

(operating-system
 (inherit installation-os)
 ;; Use non-free Linux and firmware
 (kernel linux)
 (firmware (list linux-firmware amd-microcode))
 ;; (initrd microcode-initrd)

 (host-name "based")
 (timezone "America/Chicago")
 (locale "en_US.utf8")

 (packages (append (list btrfs-progs cryptsetup git-minimal vim)
             (operating-system-packages installation-os)))

 (services
  (cons*

   ;; Include the channel file so that it can be used during installation.
   (simple-service 'channels-file
                   etc-service-type
                   (list `("channels.scm" ,%channels-file)))

   (modify-services (operating-system-user-services installation-os)
                    (guix-service-type
                     config =>
                     (guix-configuration
                      (substitute-urls
                       (list "https://ci.guix.gnu.org"
                             "https://substitutes.nonguix.org"))
                      (authorized-keys
                       (cons %signing-key
                             %default-authorized-guix-keys))
                      (channels %channels)))))))
