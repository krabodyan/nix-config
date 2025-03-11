{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.de-packages;
in {
  options = {
    module.de-packages = {
      enable = mkEnableOption "enable de-packages";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      grim
      slurp
      wlr-randr
      wl-gammactl
      wev
      xwayland
      wl-clipboard
    ];
  };
}
