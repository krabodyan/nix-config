{ config, ... }: {
  home.sessionVariables = {
    XDG_SESSION_DESKTOP = "river";
    XDG_CURRENT_DESKTOP = "river";
    XDG_SESSION_TYPE = "wayland";
    EGL_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland,x11,windows";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11,*";
    GTK_USE_PORTAL = 1;
    # NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    _JAVA_AWT_WM_NONEREPARENTING = 1;
    RUST_BACKTRACE = 1;
    XDG_SCREENSHOTS_DIR = "~/pictures";
    FLAKE = "${config.home.homeDirectory}/flake";
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_DISABLE_RDD_SANDBOX = 1;
    NIXPKGS_ALLOW_UNFREE = 1;
    # WLR_NO_HARDWARE_CURSORS = 1; # grim + slurp cursor bug, dont use
  };
}
