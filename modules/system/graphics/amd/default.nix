{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.graphics.amdgpu;
in {
  options = {
    module.graphics.amdgpu = {
      enable = mkEnableOption "amd gpu support";
    };
  };
  config = mkIf cfg.enable {
    hardware.graphics = {
      extraPackages = with pkgs; [
        libva
        libva-vdpau-driver
      ];
    };
  };
}
