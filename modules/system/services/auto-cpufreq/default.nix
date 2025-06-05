{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.services.auto-cpufreq;
in {
  options = {
    module.services.auto-cpufreq = {
      enable = mkEnableOption "auto-cpufreq";
      enableDaemon = mkOption {
        type = lib.types.bool;
        example = true;
      };
    };
  };
  config = mkIf cfg.enable {
    powerManagement.cpuFreqGovernor = "powersave";
    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
