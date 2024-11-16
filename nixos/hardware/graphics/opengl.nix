{ pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver libvdpau-va-gl ];
    # extraPackages32 = with pkgs.pkgsi686Linux; [
    #   intel-media-driver
    #   libvdpau-va-gl
    #   nvidia-vaapi-driver
    #   pkgs.linuxPackages_latest.nvidia_x11.lib32
    # ];
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
