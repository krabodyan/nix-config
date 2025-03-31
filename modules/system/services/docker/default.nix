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
      enable = mkEnableOption "enable docker";
      storageDriver = mkOption {
        type = lib.types.nullOr (lib.types.str);
        example = "btrfs";
        default = null;
      };
    };
  };
  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
      inherit (cfg) storageDriver;
    };
    systemd.services.docker.wantedBy = lib.mkForce [];
    systemd.sockets.docker.wantedBy = lib.mkForce [];
  };
}
