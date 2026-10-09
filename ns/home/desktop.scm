(define-module (ns home desktop)
  #:use-module (gnu)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (nongnu packages mozilla)
  #:export (home-desktop-service-type))

(use-package-modules
 admin algebra aspell compression curl disk fonts fontutils freedesktop gimp
 glib gnome gnome-xyz gstreamer kde-frameworks linux music package-management
 emacs vim texlive password-utils pdf pulseaudio shellutils ssh syncthing
 terminals image-viewers video rust rust-apps web-browsers window-management wget
 xdisorg xorg gnuzilla pkg-config)

(define (home-desktop-profile-service config)
  (list
   ;; Desktop(s)
   sway
   waybar

   ;; Desktop utilities
   swayidle       ; Idle daemon
   swaylock       ; Lock screen
   fuzzel         ; App launcher
   mako           ; Notifications
   gammastep      ; Color temps
   wdisplays      ; Display mgmt
   wbg            ; Wallpaper
   grimshot       ; Screenshots
   wl-clipboard   ; Clipboard
   network-manager-applet

   ;; Terminal emulators
   foot

   ;; Package managers
   flatpak

   ;; XDG
   xdg-desktop-portal
   xdg-desktop-portal-gtk
   xdg-desktop-portal-wlr
   xdg-utils
   xdg-dbus-proxy
   shared-mime-info

   ;; X11
   xorg-server-xwayland ; Xorg compat

   ;; GTK themes
   matcha-theme
   papirus-icon-theme
   breeze-icons
   gnome-themes-extra
   adwaita-icon-theme

   ;; Fonts
   font-abattis-cantarell
   font-awesome
   font-nerd-symbols
   font-fira-code
   font-fira-mono
   font-iosevka-ss08
   font-iosevka-aile
   font-jetbrains-mono
   font-google-noto
   font-google-noto-emoji
   font-liberation
   font-hack
   fontmanager

   ;; Diagnostics
   lm-sensors
   procps
   htop

   ;; Web
   firefox
   icecat

   ;; Editors
   emacs-next-pgtk
   neovim

   ;; Authentication
   password-store

   ;; Audio devices and media playback
   mpv
   mpv-mpris
   yt-dlp
   playerctl
   alsa-utils
   pavucontrol

   ;; Graphics
   gimp
   ueberzug

   ;; Latex
   ;; texlive

   ;; PDF reader
   zathura
   zathura-pdf-mupdf

   ;; CLI.
   fzf
   ispell
   ripgrep
   lf
   bc

   ;; zsh
   zsh-syntax-highlighting
   zsh-completions

   ;; File syncing
   syncthing-gtk

   ;; Development
   ;; TODO: move this to a dedicated service-type!
   rust
   rust-analyzer
   ;;rust-cargo

   ;; General utilities
   curl
   wget
   openssh
   zip
   unzip))

(define (home-desktop-environment-variables config)
  '(("_JAVA_AWT_WM_NONREPARENTING" . "1")))

(define home-desktop-service-type
  (service-type (name 'home-desktop)
                (description "My desktop environment service.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-desktop-profile-service)
                       (service-extension
                        home-environment-variables-service-type
                        home-desktop-environment-variables)))
                (default-value #f)))
