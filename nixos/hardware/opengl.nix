{ config, pkgs, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  environment.systemPackages = with pkgs; [
    mesa
    mesa-demos
    vulkan-tools
    intel-gpu-tools
    libva-utils
  ];
}
