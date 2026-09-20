(define-module (ns systems ulysses)
  #:use-module (ns systems base)
  #:use-module (ns home common)
  #:use-module (guix)
  #:use-module (guix channels)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu services)
  #:use-module (gnu system))

(operating-system
 (inherit base-system)
 (host-name "ulysses")

 (packages (cons* btrfs-progs
                  (operating-system-packages base-system)))

 (mapped-devices
  (list
   (mapped-device
    (source (uuid "TODO"))
    (target "cryptroot")
    (type luks-device-mapping))
   (mapped-device
    (source (uuid "TODO"))
    (target "cryptswap")
    (type luks-device-mapping)
    (arguments '(#:key-file "/etc/cryptswap.key")))))

 (file-systems
  (cons*
   (file-system
    (mount-point "/boot")
    (device (uuid "TODO"))
    (type "ext4"))
   (file-system
     (mount-point "/")
     (device "/dev/mapper/cryptroot")
     (type "btrfs")
     (options "subvol=@,compress=zstd"))
   (file-system
     (mount-point "/home")
     (device "/dev/mapper/cryptroot")
     (type "btrfs")
     (options "subvol=@home,compress=zstd"))
   (file-system
     (mount-point "/var")
     (device "/dev/mapper/cryptroot")
     (type "btrfs")
     (options "subvol=@var,compress=zstd"))
   (file-system
     (mount-point "/gnu")
     (device "/dev/mapper/cryptroot")
     (type "btrfs")
     (options "subvol=@gnu,compress=zstd"))
   %base-file-systems))

 (swap-devices
  (list
   (swap-space
    (target "/dev/mapper/cryptswap")
    (dependencies mapped-devices))))

 (services
  (append
   (operating-system-user-services base-system)
   (list
    (guix-home-config
     (home-environment
      (services common-home-services)))))))
