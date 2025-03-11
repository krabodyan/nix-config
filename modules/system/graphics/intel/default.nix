{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.graphics.intel;
in {
  options = {
    module.graphics.intel = {
      enable = mkEnableOption "enable intel gpu support";
    };
  };
  config = mkIf cfg.enable {
    hardware.graphics = {
      extraPackages = with pkgs; [intel-media-driver libvdpau-va-gl];
    };
    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
    environment.systemPackages = with pkgs; [
      intel-gpu-tools
    ];
  };
}
