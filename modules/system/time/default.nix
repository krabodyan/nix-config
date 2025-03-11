{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.time;
in {
  options = {
    module.time = {
      enable = mkEnableOption "enable kyiv timezone";
    };
  };
  config = mkIf cfg.enable {
    time = {
      timeZone = "Europe/Kiev";
      hardwareClockInLocalTime = true;
    };
  };
}
