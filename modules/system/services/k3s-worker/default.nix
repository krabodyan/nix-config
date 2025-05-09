{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.services.k3s-worker;
in {
  options = {
    module.services.k3s-worker = {
      enable = mkEnableOption "enables k3s";
      token = mkOption {
        type = lib.types.str;
      };
      server = mkOption {
        type = lib.types.str;
      };
    };
  };
  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "agent";
      token = cfg.token;
      serverAddr = cfg.server;
    };
  };
}
