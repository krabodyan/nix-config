{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.services.docker;
in {
  options = {
    module.services.docker = {
      enable = mkEnableOption "docker";
      storageDriver = mkOption {
        type = lib.types.nullOr (lib.types.str);
        example = "overlay2";
        default = "overlay2";
      };
      nvidia = mkOption {
        type = lib.types.bool;
        default = false;
        example = true;
      };
    };
  };
  config = mkIf cfg.enable {
    hardware.nvidia-container-toolkit.enable = cfg.nvidia;
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
      inherit (cfg) storageDriver;
    };
  };
}
