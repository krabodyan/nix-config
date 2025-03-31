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
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };
    hardware.graphics = {
      extraPackages = with pkgs; [intel-media-driver libvdpau-va-gl vaapiVdpau intel-media-sdk];
    };
    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
    environment.systemPackages = with pkgs; [
      intel-gpu-tools
    ];
    services.udev.extraRules = ''
      SUBSYSTEM=="drm", KERNEL=="card*", ATTRS{vendor}=="0x8086", SYMLINK+="dri/igpu"
    '';
  };
}
