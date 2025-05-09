{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.services.k3s-server;
in {
  options = {
    module.services.k3s-server = {
      enable = mkEnableOption "enables k3s";
      token = mkOption {
        type = lib.types.str;
      };
    };
  };
  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "server";
      token = cfg.token;
      clusterInit = true;
      # extraFlags = ["--disable=traefik"];
    };
  };
}
