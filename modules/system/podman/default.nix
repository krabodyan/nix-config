{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  cfg = config.module.podman;
in {
  options = {
    module.podman = {
      enable = mkEnableOption "podman";
      nvidia = mkOption {
        type = lib.types.bool;
        default = false;
        example = true;
      };
    };
  };
  config = mkIf cfg.enable {
    hardware.nvidia-container-toolkit.enable = cfg.nvidia;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
    environment.systemPackages = [pkgs.podman-compose];
  };
}
