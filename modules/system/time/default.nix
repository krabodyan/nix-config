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
      enable = mkEnableOption "kyiv timezone";
    };
  };
  config = mkIf cfg.enable {
    time = {
      timeZone = "Europe/Kiev";
      hardwareClockInLocalTime = false;
    };
  };
}
