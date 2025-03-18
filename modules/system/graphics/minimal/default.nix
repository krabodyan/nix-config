{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.graphics.minimal;
in {
  options = {
    module.graphics.minimal = {
      enable = mkEnableOption "enable minimal graphics support";
    };
  };
  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
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
      mesa
      mesa-demos
      vulkan-tools
      libva-utils
    ];
  };
}
