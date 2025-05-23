{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.nh;
in {
  options = {
    module.nh = {
      enable = mkEnableOption "nh";
    };
  };
  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.extraArgs = "--keep 5 --keep-since 3d";
      flake = "${config.home.homeDirectory}/flake";
    };
  };
}
