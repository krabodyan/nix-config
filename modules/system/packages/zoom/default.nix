{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.zoom;
in {
  options = {
    module.zoom = {
      enable = mkEnableOption "zoom";
    };
  };
  config = mkIf cfg.enable {
    programs.zoom-us = {
      enable = true;
    };
  };
}
