{
  lib,
  config,
  hostname,
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
    services.tlp = {
      enable = true;
      settings =
        if hostname == "zenbook"
        then {
          CPU_DRIVER_OPMODE_ON_AC = "active";
          CPU_DRIVER_OPMODE_ON_BAT = "active";

          CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;
          CPU_HWP_DYN_BOOST_ON_AC = 1;
          CPU_HWP_DYN_BOOST_ON_BAT = 0;

          SCHED_POWERSAVE_ON_AC = 0;
          SCHED_POWERSAVE_ON_BAT = 1;

          # Disk and PCIe
          DISK_IDLE_SECS_ON_AC = 1;
          DISK_IDLE_SECS_ON_BAT = 1;
          MAX_LOST_WORK_SECS_ON_AC = 5;
          MAX_LOST_WORK_SECS_ON_BAT = 10;
          RUNTIME_PM_ON_AC = "auto";
          RUNTIME_PM_ON_BAT = "auto";
          PCIE_ASPM_ON_AC = "default";
          PCIE_ASPM_ON_BAT = "powersave";

          # USB
          USB_AUTOSUSPEND = 1;
          USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN = 0;

          # Networking
          WIFI_PWR_ON_AC = "off";
          WIFI_PWR_ON_BAT = "on";
          DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wifi wwan";
          DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";

          # cat /sys/firmware/acpi/platform_profile_choices
          PLATFORM_PROFILE_ON_AC = "balanced";
          PLATFORM_PROFILE_ON_BAT = "quiet";

          # Sleep behavior
          MEM_SLEEP_ON_AC = "deep";
          MEM_SLEEP_ON_BAT = "deep";
        }
        else {
          CPU_SCALING_GOVERNOR_ON_AC = "powersave";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          CPU_ENERGY_PERF_POLICY_ON_AC = "powersave";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          PLATFORM_PROFILE_ON_AC = "balanced";
          PLATFORM_PROFILE_ON_BAT = "quiet";
          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;
          CPU_HWP_DYN_BOOST_ON_AC = 1;
          CPU_HWP_DYN_BOOST_ON_BAT = 0;
          RUNTIME_PM_DRIVER_BLACKLIST = "mei_me nouveau nvidia pcieport";
          MEM_SLEEP_ON_AC = "s2idle";
          MEM_SLEEP_ON_BAT = "s2idle";
        };
    };
    systemd.services.tlp.enable = cfg.enableDaemon;
  };
}
