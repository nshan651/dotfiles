(define-module (ns systems golemxiv)
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
 (host-name "golemxiv")

 (packages (cons* btrfs-progs
                  (operating-system-packages base-system)))

 ;; Map BOTH the encrypted root and swap partitions
 (mapped-devices
  (list
   (mapped-device
    (source (uuid "PLACEHOLDER-ROOT-UUID"))
    (target "cryptroot")
    (type luks-device-mapping))

   (mapped-device
    (source (uuid "PLACEHOLDER-SWAP-UUID"))
    (target "cryptswap")
    (type luks-device-mapping))))

 (swap-devices
  (list
   (swap-space
    (target "/dev/mapper/cryptswap")
    (dependencies mapped-devices))))

 (file-systems
  (cons*
   (file-system
    (mount-point "/")
    (device "/dev/mapper/cryptroot")
    (type "btrfs")
    (options "subvol=@,compress=zstd,space_cache=v2")
    (dependencies mapped-devices))

   (file-system
    (mount-point "/home")
    (device "/dev/mapper/cryptroot")
    (type "btrfs")
    (options "subvol=@home,compress=zstd,space_cache=v2")
    (dependencies mapped-devices))

   (file-system
    (mount-point "/.snapshots")
    (device "/dev/mapper/cryptroot")
    (type "btrfs")
    (options "subvol=@snapshots,compress=zstd,space_cache=v2")
    (dependencies mapped-devices))

   (file-system
    (mount-point "/boot")
    (device (uuid "PLACEHOLDER-BOOT-UUID"))
    (type "ext4"))

   %base-file-systems))

 (services
  (append
   (operating-system-user-services base-system)
   (list
    (guix-home-config
     (home-environment
      (services common-home-services)))))))
