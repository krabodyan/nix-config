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
      enable = mkEnableOption "iwd";
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
          Network.EnableIPv6 = false;
          Settings.AutoConnect = true;
          General.EnableNetworkConfiguration = false;
          DriverQuirks.UseDefaultInterface = true;
          Scan = {
            DisablePeriodicScan = false;
            InitialPeriodicScanInterval = 0;
            MaximumPeriodicScanInterval = 300;
          };
        };
      };
    };
    systemd.services.iwd.wantedBy = mkIf (!cfg.enableDaemon) (lib.mkForce []);
  };
}
