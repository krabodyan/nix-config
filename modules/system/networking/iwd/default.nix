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
      enable = mkEnableOption "enable wireless with iwd";
      enableDaemon = mkOption {
        type = lib.types.bool;
        example = true;
        default = true;
      };
    };
  };
  config = mkIf cfg.enable {
    networking.wireless = {
      iwd = {
        enable = true;
        settings = {
          General = {
            UseDefaultInterface = true;
            EnableNetworkConfiguration = true;
          };
          Network = {EnableIPv6 = true;};
          Settings.AutoConnect = true;
          Scan.DisablePeriodicScan = false;
        };
      };
    };
    systemd.services.iwd.wantedBy = mkIf (!cfg.enableDaemon) (lib.mkForce []);
  };
}
