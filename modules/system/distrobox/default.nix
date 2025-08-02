{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.distrobox;
in {
  options = {
    module.distrobox = {
      enable = mkEnableOption "distrobox";
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.distrobox];
  };
}
