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

 (kernel-arguments
  (cons* "modprobe.blacklist=acer_wmi,wl"
         (operating-system-user-kernel-arguments base-system)))

 (packages (cons* btrfs-progs
                  (operating-system-packages base-system)))

 (mapped-devices
  (list
   (mapped-device
    (source (uuid "cb72bba9-dc6d-48cd-b055-28d5656aa45c"))
    (target "cryptroot")
    (type luks-device-mapping))
   (mapped-device
    (source (uuid "9a0ad375-b0d5-4674-b805-0817d9d23666"))
    (target "cryptswap")
    (type luks-device-mapping))))

 (file-systems
  (cons*
   (file-system
    (mount-point "/boot")
    (device (uuid "58a72f35-a658-4d4b-a076-bdca7f78022e"))
    (type "ext4"))
   (file-system
     (mount-point "/")
     (device "/dev/mapper/cryptroot")
     (type "btrfs")
     (options "subvol=@,compress=zstd,space_cache=v2,noatime"))
   (file-system
     (mount-point "/home")
     (device "/dev/mapper/cryptroot")
     (type "btrfs")
     (options "subvol=@home,compress=zstd,space_cache=v2,noatime"))
   (file-system
     (mount-point "/var")
     (device "/dev/mapper/cryptroot")
     (type "btrfs")
     (options "subvol=@var,compress=zstd,space_cache=v2,noatime"))
   (file-system
     (mount-point "/gnu")
     (device "/dev/mapper/cryptroot")
     (type "btrfs")
     (options "subvol=@gnu,compress=zstd,space_cache=v2,noatime"))
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
