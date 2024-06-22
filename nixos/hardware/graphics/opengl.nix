{ pkgs, ... }: {
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  environment.systemPackages = with pkgs; [
    mesa
    mesa-demos
    vulkan-tools
    intel-gpu-tools
    libva-utils
  ];
}
