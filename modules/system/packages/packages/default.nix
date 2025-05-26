{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.packages;
in {
  options = {
    module.packages = {
      enable = mkEnableOption "default packages";
      extraPackages = mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
      };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        busybox

        inxi

        lm_sensors
        zip

        file
        lshw

        usbutils
        pciutils
        ntfs3g
        acpi

        iotop
        iftop
      ]
      ++ cfg.extraPackages;
  };
}
