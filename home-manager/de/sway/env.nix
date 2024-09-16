{
  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
    MOZ_ENABLE_WAYLAND = 1;
    SDL_VIDEODRIVER = "wayland,x11,windows";
    _JAVA_AWT_WM_NONEREPARENTING = 1;
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Sway";
    XDG_SCREENSHOTS_DIR = "~/pictures";
    RUST_BACKTRACE = 1;
    # WLR_RENDERER = "vulkan";
    #"WLR_RENDERER_ALLOW_SOFTWARE,1"
    # WLR_DRM_NO_ATOMIC = 1;
    # __GL_VRR_ALLOWED = 0;
    __GL_THREADED_OPTIMIZATIONS = 0;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
  };
}
