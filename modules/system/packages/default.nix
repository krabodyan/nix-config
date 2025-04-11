{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.packages;
in {
  options = {
    module.packages = {
      enable = mkEnableOption "enable default packages";
      steam = mkEnableOption "enable steam";
      extraPackages = mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
      };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        gnumake
        git
        sops
        gcc
        inxi
        wget
        killall
        lm_sensors
        zip
        unzip
        file
        lshw
        usbutils
        pciutils
        acpi
        ntfs3g
        iotop
        iftop
        busybox
        screen
      ]
      ++ cfg.extraPackages;
    programs.steam = mkIf cfg.steam {
      enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}
