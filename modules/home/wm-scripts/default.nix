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
      enable = mkEnableOption "wm-scripts";
      touchpadDevice = mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = let
      send = ''
        ${pkgs.libnotify}/bin/notify-send \
        -t 400 \
        -a swaynotify \
        --urgency low \
        -h string:x-canonical-private-synchronous:swaynotify \
      '';
    in (
      map
      (file: (import file {
        inherit pkgs send colors;
        inherit (cfg) touchpadDevice;
      }))
      (lib.flatten [
        ./volume.nix
        ./brightness.nix
        ./microphone.nix
        ./screenshot.nix

        (lib.optional
          config.module.sway.enable
          ./touchpad-sway.nix)

        (lib.optional
          config.module.river.enable
          ./touchpad-river.nix)
      ])
    );
  };
}
