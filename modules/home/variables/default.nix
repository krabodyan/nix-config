{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.variables;
in {
  options = {
    module.variables = {
      enable = mkEnableOption "enable variables";
    };
  };
  config = mkIf cfg.enable {
    home.sessionPath = ["$HOME/.cargo/bin"];
    home.sessionVariables = {
      EGL_PLATFORM = "wayland";
      CLUTTER_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland,x11,*";
      QT_QPA_PLATFORM = "wayland;xcb";
      # SDL_VIDEODRIVER = "wayland,x11,windows";
      GTK_USE_PORTAL = 1;
      NIXOS_OZONE_WL = 1;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      _JAVA_AWT_WM_NONEREPARENTING = 1;
      XDG_SCREENSHOTS_DIR = "~/pictures";
      MOZ_ENABLE_WAYLAND = 1;
      NIXPKGS_ALLOW_UNFREE = 1;
    };
  };
}
