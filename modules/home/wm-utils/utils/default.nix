{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.wm-utils;
in {
  options = {
    module.wm-utils = {
      enable = mkEnableOption "wm related utils";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      grim
      slurp
      swaybg

      wlr-randr
      wl-gammactl
      wl-clipboard

      lswt
      wev
    ];
  };
}
