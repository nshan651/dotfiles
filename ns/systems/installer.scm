;;; A custom install image, donwload this as a qcow iso.
;; guix system image -L ~/.dotfiles -t iso9660 installer.scm
(define-module (ns systems installer)
  #:use-module (ns systems base)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:use-module (gnu packages linux )
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages cryptsetup)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

(operating-system
 (inherit base-system)

 (host-name "based")

 (file-systems (cons (file-system
                      (mount-point "/")
                      (device (file-system-label "guix-installer"))
                      (type "ext4"))
                     %base-file-systems))

 (packages (append (list btrfs-progs cryptsetup git)
                   (operating-system-packages base-system))))
