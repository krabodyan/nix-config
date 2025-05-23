{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.services.nfs;
in {
  options = {
    module.services.nfs = {
      enable = mkEnableOption "nfs";
    };
  };
  config = mkIf cfg.enable {
    services.nfs = {
      server = {
        enable = true;
        exports = ''
          /data/k8s 192.168.1.0/24(rw,no_root_squash,sync,no_subtree_check)
        '';
      };
    };
  };
}
