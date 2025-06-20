{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.graphics.minimal;
in {
  options = {
    module.graphics.minimal = {
      enable = mkEnableOption "minimal graphics support";
      enable32Bit = mkOption {
        type = lib.types.bool;
        default = false;
        example = true;
      };
    };
  };
  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      inherit (cfg) enable32Bit;
    };
    environment.sessionVariables = {
      GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]);
      VDPAU_DRIVER = "va_gl";
    };
    environment.systemPackages = with pkgs; [
      mesa-demos
      vulkan-tools
      libva-utils
    ];
  };
}
