{
  lib,
  pkgs,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.river;
in {
  options = {
    module.river = {
      enable = mkEnableOption "enable river wm";
      background = mkOption {
        type = lib.types.str;
      };
      extraConfig = mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [swaybg wideriver lswt];
    wayland.windowManager.river = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      extraConfig = import ./init.nix {
        inherit colors lib config;
        inherit (cfg) background extraConfig;
      };
    };
  };
}
