{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.xdg-portal;
in {
  options = {
    module.xdg-portal = {
      enable = mkEnableOption "enable xdg-portal";
      terminal = mkOption {
        type = lib.types.str;
        example = "foot.desktop";
      };
    };
  };
  config = mkIf cfg.enable {
    xdg.terminal-exec = {
      enable = true;
      settings.default = [cfg.terminal];
    };
    environment.variables = {
      TERMCMD = "foot -a floaterm";
      GDK_DEBUG = "portals";
    };
    environment.systemPackages = [pkgs.xdg-desktop-portal-termfilechooser];
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = "wlr";
        common."org.freedesktop.impl.portal.FileChooser" = ["xdg-desktop-portal-termfilechooser"];
      };
      extraPortals = with pkgs; [xdg-desktop-portal-gtk xdg-desktop-portal-termfilechooser];
      wlr = {
        enable = true;
        settings = {
          screencast = {
            output_name = "eDP-1";
            max_fps = 30;
            chooser_type = "simple";
            chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
          };
        };
      };
    };
  };
}
