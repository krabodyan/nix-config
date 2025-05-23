{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption mkMerge;
  cfg = config.module.graphics.intel;
in {
  options = {
    module.graphics.intel = {
      enable = mkEnableOption "intel gpu support";
      newer = mkOption {
        type = lib.types.bool;
      };
    };
  };
  config = mkMerge [
    (
      mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          intel-gpu-tools
        ];
        services.udev.extraRules = ''
          SUBSYSTEM=="drm", KERNEL=="card*", ATTRS{device}=="0x9a68", SYMLINK+="dri/igpu"
        '';
      }
    )
    (
      mkIf (cfg.enable
        && cfg.newer) {
        hardware.graphics = {
          extraPackages = with pkgs; [
            vpl-gpu-rt
            intel-media-driver
          ];
        };
        environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
      }
    )
    (
      mkIf (cfg.enable
        && !cfg.newer) {
        hardware.graphics = {
          extraPackages = with pkgs; [
            intel-media-sdk
            vaapi-intel-hybrid
          ];
        };
        environment.sessionVariables.LIBVA_DRIVER_NAME = "i965";
      }
    )
  ];
}
