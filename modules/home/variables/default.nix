{
  lib,
  hidpi,
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
    home.sessionVariables =
      {
        GDK_BACKEND = "wayland,x11,*";
        SDL_VIDEODRIVER = "wayland";

        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

        _JAVA_AWT_WM_NONREPARENTING = 1;

        GTK_USE_PORTAL = 1;
        NIXOS_OZONE_WL = 1;
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        MOZ_ENABLE_WAYLAND = 1;
        NIXPKGS_ALLOW_UNFREE = 1;

        XDG_SCREENSHOTS_DIR = "~/pictures";
      }
      // lib.optionalAttrs hidpi {
        QT_ENABLE_HIGHDPI_SCALING = 1;
        QT_SCALE_FACTOR = ""; # 1.35; onlyoffice
        GDK_SCALE = 1;
        GDK_DPI_SCALE = 1.35;
        _JAVA_OPTIONS = "-Dsun.java2d.uiScale=1.35";
      };
  };
}
