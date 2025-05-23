{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.bluetooth;
in {
  options = {
    module.bluetooth = {
      enable = mkEnableOption "bluetooth";
    };
  };
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
}
