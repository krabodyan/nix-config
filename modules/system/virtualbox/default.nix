{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.virtualbox;
in {
  options = {
    module.virtualbox = {
      enable = mkEnableOption "virtualbox";
    };
  };
  config = mkIf cfg.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      # enableKvm = true;
      # addNetworkInterface = false;
    };
  };
}
