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
      enable = mkEnableOption "variables";
    };
  };
  config = mkIf cfg.enable {
    home.sessionPath = ["$HOME/.cargo/bin"];
    home.sessionVariables = {
      GDK_BACKEND = "wayland,x11,*";
      SDL_VIDEODRIVER = "wayland";

      QT_QPA_PLATFORM = "wayland-egl";
      QT_SCALE_FACTOR = 1;
      QT_ENABLE_HIGHDPI_SCALING = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

      _JAVA_AWT_WM_NONREPARENTING = 1;

      GTK_USE_PORTAL = 1;
      NIXOS_OZONE_WL = 1;
      MOZ_ENABLE_WAYLAND = 1;
      NIXPKGS_ALLOW_UNFREE = 1;

      XDG_SCREENSHOTS_DIR = "~/pictures";
    };
  };
}
