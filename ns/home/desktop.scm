(define-module (ns home desktop)
  #:use-module (gnu)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (nongnu packages mozilla)
  #:export (home-desktop-service-type))

(use-package-modules aspell compression curl fonts fontutils freedesktop gimp glib gnome gnome-xyz
                     gstreamer kde-frameworks linux music package-management emacs vim texlive
                     password-utils pdf pulseaudio shellutils ssh syncthing terminals
                     video rust rust-apps web-browsers wget wm xdisorg xorg gnuzilla pkg-config)

(define (home-desktop-profile-service config)
  (list sway
        ;; dwl
        swayidle ; Idle daemon
        swaylock

	waybar
        fuzzel
        wl-clipboard
        mako ; Notification system
        gammastep ; Set color temps based on time of day

	wdisplays

        grimshot ;; grimshot --notify copy area
        network-manager-applet

        ;; Terminal emulator
        foot
        alacritty

        ;; Compatibility for older Xorg applications
        xorg-server-xwayland

        ;; Keyboard shortcut manager.
        keyd

        ;; Flatpak. 
        ;; flatpak

        ;; XDG utilitie.
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-utils
        xdg-dbus-proxy
        shared-mime-info

        ;; Appearance.
        matcha-theme
        papirus-icon-theme
        breeze-icons
        gnome-themes-extra
        adwaita-icon-theme

        ;; Fonts.
	font-abattis-cantarell
        font-awesome
	font-fira-code
        font-iosevka-ss08
        font-iosevka-aile
        font-jetbrains-mono
	font-google-noto
	font-google-noto-emoji
        font-liberation
	fontmanager

        ;; Browsers.
        firefox
        icecat

        ;; Editors.
        emacs
        neovim

        ;; Authentication
        password-store

        ;; Audio devices and media playback
        mpv
        mpv-mpris
        youtube-dl
        playerctl
        alsa-utils
        pavucontrol

        ;; Graphics
        gimp-next

	;; Latex
	;; texlive

        ;; PDF reader
        zathura
        zathura-pdf-mupdf

	;; CLI.
	fzf
	ispell
	ripgrep

	;; zsh.
	zsh-syntax-highlighting
	zsh-completions

        ;; File syncing
        syncthing-gtk

	;; Development
	;; TODO: move this to a dedicated service-type!
	rust
	rust-analyzer
	rust-cargo

	pkg-config
	libinput
	eudev
	libxkbcommon

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
