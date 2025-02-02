{ config, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = false;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "570.86.16";
    #   sha256_64bit = "sha256-RWPqS7ZUJH9JEAWlfHLGdqrNlavhaR1xMyzs8lJhy9U=";
    #   sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
    #   openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
    #   settingsSha256 = "sha256-zj173HCZJaxAbVV/A2sbJ9IPdT1+3yrwyxD+AQdkSD8=";
    #   persistencedSha256 =
    #     "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
    # };
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
