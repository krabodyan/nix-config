{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.jq;
in {
  options = {
    module.jq = {
      enable = mkEnableOption "enables jq";
    };
  };
  config = mkIf cfg.enable {
    programs.jq = {
      enable = true;
      colors = {
        null = "0;31";
        false = "0;31";
        true = "0;31";
        numbers = "0;31";
        strings = "0;34";
        arrays = "2;37";
        objects = "2;37";
        objectKeys = "0;37";
      };
    };
  };
}
