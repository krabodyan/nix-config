{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.udev-rules;
in {
  options = {
    module.kernel = {
      enable = mkEnableOption "enabled udev rules for usb mouse";
      platformio = mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", TAG+="uaccess"
      ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTR{power/wakeup}="disabled"
    '';
    services.udev.packages =
      mkIf cfg.platformio
      [pkgs.platformio-core.udev];
  };
}
