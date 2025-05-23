{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.jq;
in {
  options = {
    module.jq = {
      enable = mkEnableOption "jq";
    };
  };
  config = mkIf cfg.enable {
    programs.jq = {
      enable = true;
      colors = {
        null = "0;91";
        false = "0;91";
        true = "0;91";
        numbers = "0;91";
        strings = "0;34";
        arrays = "2;37";
        objects = "2;37";
        objectKeys = "0;37";
      };
    };
  };
}
