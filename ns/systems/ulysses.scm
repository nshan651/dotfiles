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

 ;; Map HDD with LUKS encryption.
 (mapped-devices
  (list (mapped-device
         (source (uuid "2f8482d3-bfa4-4bb9-8951-5ad83c201a7f"))
         (target "cryptroot")
         (type luks-device-mapping))))

 ;; The list of file systems that get "mounted".  The unique
 ;; file system identifiers there ("UUIDs") can be obtained
 ;; by running 'blkid' in a terminal.
 (file-systems (cons* (file-system
			           (mount-point "/")
			           (device "/dev/mapper/cryptroot")
			           (type "ext4")
			           (dependencies mapped-devices))
			          %base-file-systems))
 (services
  (append
   (operating-system-user-services base-operating-system)
   (list
    (guix-home-config
     (home-environment
      (services common-home-services)))))))
