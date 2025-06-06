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
      enable = mkEnableOption "river wm";
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
    home.packages = with pkgs; [swaybg wideriver];
    home.sessionVariables = {
      XDG_SESSION_DESKTOP = "river";
      XDG_CURRENT_DESKTOP = "river";
    };
    wayland.windowManager.river = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      systemd.extraCommands = [
        "systemctl --user reset-failed"
        "systemctl --user stop river-session.target"
        "systemctl --user start river-session.target"
        "dbus-update-activation-environment --systemd --all"
      ];
      extraConfig = import ./init.nix {
        inherit colors lib config;
        inherit (cfg) background extraConfig;
      };
    };
  };
}
