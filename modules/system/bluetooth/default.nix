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
      enable = mkEnableOption "enable bluetooth";
    };
  };
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    systemd.services.bluetooth.wantedBy = lib.mkForce [];
    systemd.targets.bluetooth.wantedBy = lib.mkForce [];
  };
}
