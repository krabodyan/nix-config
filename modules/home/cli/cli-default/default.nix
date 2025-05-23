{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.cli-default;
in {
  options = {
    module.cli-default = {
      enable = mkEnableOption "default cli apps";
      extra = mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        pv
        yq
        jiq

        xdg-utils

        lsof
        iptables
        tcpdump

        dust
        dua
        dysk

        pulsemixer
      ]
      ++ cfg.extra;
  };
}
