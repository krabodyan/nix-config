{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.powerManagement;
in {
  options = {
    module.powerManagement = {
      enable = mkEnableOption "power management ";
    };
  };
  config = mkIf cfg.enable {
    powerManagement = {
      enable = true;
    };
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        energy_performance_preference = "power";
        platform_profile = "quiet";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
        energy_performance_preference = "balance_power";
        platform_profile = "balanced";
      };
    };
  };
}
