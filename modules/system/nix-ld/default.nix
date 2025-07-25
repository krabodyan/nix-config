{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.nix-ld;
in {
  options = {
    module.nix-ld = {
      enable = mkEnableOption "nix-ld";
    };
  };

  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
      libraries = with pkgs; [
        # Without these it silently fails
        (lib.getLib elfutils)
        SDL
        SDL2
        SDL2_image
        SDL2_mixer
        SDL2_ttf
        SDL_image
        SDL_mixer
        SDL_ttf
        alsa-lib
        at-spi2-atk
        at-spi2-core # CrossCode
        atk
        atkmm
        bzip2
        cairo
        cups
        curlWithGnuTls
        dbus
        dbus-glib
        expat
        ffmpeg
        file # called by steam's setup.sh
        flac
        fontconfig
        freeglut
        freetype
        fuse
        fuse3
        gdk-pixbuf
        giflib
        glew110
        glib
        gsettings-desktop-schemas
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-ugly
        gst_all_1.gstreamer
        gtk2
        gtk3
        gtk4
        harfbuzz
        icu
        imlib2
        json-glib
        libGL
        libGLU
        libappindicator-gtk2
        libappindicator-gtk3
        libbsd
        libcaca
        libcanberra
        libcap
        libdbusmenu-gtk2
        libdrm
        libelf
        libexif
        libgcrypt
        libglvnd
        libidn
        libidn2
        libindicator-gtk2
        libjpeg
        libmikmod
        libnotify
        libogg
        libpng
        libpng12
        libpsl
        libpulseaudio
        librsvg
        libsamplerate
        libssh
        libthai
        libtheora
        libtiff
        libudev0-shim
        libunwind
        libusb1
        libuuid
        libva
        libvdpau
        libvorbis
        libvpx
        libwebp
        libxcrypt
        libxkbcommon
        libxml2

        lsof
        mesa
        mesa.llvmPackages.llvm.lib
        mono
        ncurses
        nghttp2.lib
        nspr
        nss
        openssl
        pango
        pipewire
        pixman
        rtmpdump
        speex
        sqlite
        stdenv.cc.cc
        stdenv.cc.cc.lib
        systemd
        tbb
        udev
        util-linux
        vulkan-loader
        wayland
        xorg.libICE
        xorg.libSM
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXft
        xorg.libXi
        xorg.libXinerama
        xorg.libXmu
        xorg.libXrandr
        xorg.libXrender
        xorg.libXt
        xorg.libXtst
        xorg.libXxf86vm
        xorg.libpciaccess
        xorg.libxcb
        xorg.libxkbfile
        xorg.libxshmfence
        xorg.xkeyboardconfig
        zlib
      ];
    };
  };
}
