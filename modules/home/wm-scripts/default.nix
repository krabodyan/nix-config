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
      touchpadcommands = {
        toggleup = mkOption {
          type = lib.types.str;
        };
        toggledown = mkOption {
          type = lib.types.str;
        };
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = [
      (import ./volume.nix {inherit pkgs;})
      (import ./touchpad.nix {
        inherit pkgs;
        inherit (cfg.touchpadcommands) toggleup toggledown;
      })
      (import ./microphone.nix {inherit pkgs;})
      (import ./brightness.nix {inherit pkgs;})
      (import ./screenshot.nix {inherit pkgs colors;})
    ];
  };
}
