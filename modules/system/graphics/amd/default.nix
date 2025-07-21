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
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    hardware.amdgpu = {
      # opencl.enable = true;
      amdvlk = {
        enable = true;
        # support32Bit.enable = true;
      };
    };
  };
}
