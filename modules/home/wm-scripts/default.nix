{
  lib,
  pkgs,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.wm-scripts;
in {
  options = {
    module.wm-scripts = {
      enable = mkEnableOption "enable wm-scripts";
      touchpad = {
        type = mkOption {
          type = lib.types.enum ["river" "sway"];
        };
        device = mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
        };
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = [
      (import ./volume.nix {inherit pkgs;})
      (import ./touchpad.nix {
        inherit pkgs;
        inherit (cfg.touchpad) type device;
      })
      (import ./microphone.nix {inherit pkgs;})
      (import ./brightness.nix {inherit pkgs;})
      (import ./screenshot.nix {inherit pkgs colors;})
    ];
  };
}
