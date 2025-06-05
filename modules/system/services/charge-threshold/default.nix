{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.services.charge-threshold;
in {
  options = {
    module.services.charge-threshold = {
      enable = mkEnableOption "charge-threshold";
    };
  };
  config = mkIf cfg.enable {
    systemd.services.battery-charge-threshold = {
      wantedBy = ["local-fs.target" "suspend.target"];
      after = ["local-fs.target" "suspend.target"];
      description = "Set the battery charge threshold to 80%";
      startLimitBurst = 5;
      startLimitIntervalSec = 1;
      serviceConfig = {
        Type = "oneshot";
        Restart = "on-failure";
        ExecStart = "${pkgs.runtimeShell} -c 'echo 80 > /sys/class/power_supply/BAT?/charge_control_end_threshold'";
      };
    };
  };
}
