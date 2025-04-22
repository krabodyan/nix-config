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
      touchpad-cmd = mkOption {
        type = lib.types.str;
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = [
      (import ./volume.nix {inherit pkgs;})
      (import ./touchpad.nix {
        inherit pkgs;
        inherit (cfg) touchpad-cmd;
      })
      (import ./microphone.nix {inherit pkgs;})
      (import ./brightness.nix {inherit pkgs;})
      (import ./screenshot.nix {inherit pkgs colors;})
    ];
  };
}
