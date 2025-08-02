{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.podman;
in {
  options = {
    module.podman = {
      enable = mkEnableOption "podman";
    };
  };
  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
    environment.systemPackages = [pkgs.podman-compose];
  };
}
