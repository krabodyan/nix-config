{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.services.asus-numberpad;
in {
  options = {
    module.services.asus-numberpad = {
      enable = mkEnableOption "asus numberpad";
    };
  };
  config = mkIf cfg.enable {
    services.asus-numberpad-driver = {
      enable = true;
      layout = "up5401ea";
      wayland = true;
      runtimeDir = "/run/user/1000/";
      waylandDisplay = "wayland-1";
      ignoreWaylandDisplayEnv = false;
      config = {
        # e.g. "activation_time" = "0.5";
        # More Configuration Options
      };
    };
  };
}
