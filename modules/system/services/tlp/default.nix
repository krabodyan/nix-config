{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.services.tlp;
in {
  options = {
    module.services.tlp = {
      enable = mkEnableOption "tlp";
      enableDaemon = mkOption {
        type = lib.types.bool;
        example = true;
      };
    };
  };
  config = mkIf cfg.enable {
    powerManagement.cpuFreqGovernor = "powersave";
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        RUNTIME_PM_DRIVER_BLACKLIST = "mei_me nouveau nvidia pcieport";
      };
    };
    systemd.services.tlp.enable = cfg.enableDaemon;
  };
}
