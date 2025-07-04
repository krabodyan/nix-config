{
  lib,
  # inputs,
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
    # TODO: add to inputs

    # asus-numberpad-driver = {
    #   url = "github:asus-linux-drivers/asus-numberpad-driver";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # inputs.asus-numberpad-driver.nixosModules.default

    # services.asus-numberpad-driver = {
    #   enable = true;
    #   layout = "up5401ea";
    #   wayland = true;
    #   runtimeDir = "/run/user/1000/";
    #   waylandDisplay = "wayland-1";
    #   ignoreWaylandDisplayEnv = false;
    #   config = {
    #     activation_time = "0.3";
    #     enabled_touchpad_pointer = "1";
    #   };
    # };
  };
}
