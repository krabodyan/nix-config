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
      enable = mkEnableOption "enable wm related utils";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      grim
      slurp
      lswt
      swaybg
      wlr-randr
      wl-gammactl
      wev
      xwayland
      wl-clipboard
    ];
  };
}
