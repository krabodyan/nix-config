{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.network-utils;
in {
  options = {
    module.network-utils = {
      enable = mkEnableOption "network utils";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lsof
      iptables
      tcpdump
      trippy
    ];
  };
}
