{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.steam;
in {
  options = {
    module.steam = {
      enable = mkEnableOption "steam";
    };
  };
  config = mkIf cfg.enable {
    programs.steam = mkIf cfg.enable {
      enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}
