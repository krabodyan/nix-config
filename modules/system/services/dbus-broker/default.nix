{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.services.dbus-broker;
in {
  options = {
    module.services.dbus-broker = {
      enable = mkEnableOption "dbus broker";
    };
  };
  config = mkIf cfg.enable {
    services.dbus = {
      enable = true;
      implementation = "broker";
    };
  };
}
