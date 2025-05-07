{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.services.k3s;
in {
  options = {
    module.services.k3s = {
      enable = mkEnableOption "enables k3s";
      enableDaemon = mkOption {
        type = lib.types.bool;
        example = true;
      };
    };
  };
  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "server";
      token = "99d12cbd-03d2-4693-bc9b-55ad00c96097";
      clusterInit = true;
      extraFlags = ["--disable=traefik"];
    };
  };
}
