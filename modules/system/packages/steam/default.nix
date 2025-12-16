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

      package = pkgs.steam.override {
        extraArgs = lib.concatStringsSep " " [
          "-nochatui"
          "-nofriendsui"
        ];
        extraEnv = {
          LD_PRELOAD = "";
          PROTON_USE_NTSYNC = 1;
          OBS_VKCAPTURE = true;
        };
      };
    };
  };
}
