{ pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  environment.systemPackages = with pkgs; [
    mesa
    mesa-demos
    vulkan-tools
    intel-gpu-tools
    libva-utils
  ];
}
