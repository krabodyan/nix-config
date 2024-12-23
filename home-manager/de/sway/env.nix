{ config, ... }: {
  home.sessionVariables = {
    GTK_USE_PORTAL = 1;
    # NIXOS_OZONE_WL = "1";
    # WLR_NO_HARDWARE_CURSORS = 1; # grim + slurp cursor bug, dont use
    FLAKE = "${config.home.homeDirectory}/flake";
    MOZ_ENABLE_WAYLAND = 1;
    SDL_VIDEODRIVER = "wayland,x11,windows";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    _JAVA_AWT_WM_NONEREPARENTING = 1;
    XDG_SESSION_TYPE = "wayland";
    # XDG_SESSION_DESKTOP = "Sway";
    XDG_SCREENSHOTS_DIR = "~/pictures";
    # __GL_THREADED_OPTIMIZATIONS = 0;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    RUST_BACKTRACE = 1;
  };
}
