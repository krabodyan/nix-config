{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.networking.iwd;
in {
  options = {
    module.networking.iwd = {
      enable = mkEnableOption "enable iwd";
      enableDaemon = mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = mkIf cfg.enable {
    networking.wireless = {
      iwd = {
        enable = true;
        settings = {
          Network.EnableIPv6 = true;
          Settings.AutoConnect = true;
          Scan.DisablePeriodicScan = true;
          General.EnableNetworkConfiguration = true;
          DriverQuirks.UseDefaultInterface = true;
        };
      };
    };
    systemd.services.iwd.wantedBy = mkIf (!cfg.enableDaemon) (lib.mkForce []);
  };
}
