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
      enable = mkEnableOption "xdg-portal";
      terminal = mkOption {
        type = lib.types.str;
        example = "foot.desktop";
      };
      portals = mkOption {
        type = lib.types.listOf lib.types.str;
        example = ["gtk" "wlr"];
      };
    };
  };
  config = mkIf cfg.enable {
    xdg.terminal-exec = {
      enable = true;
      settings.default = [cfg.terminal];
    };
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = cfg.portals;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk];
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
