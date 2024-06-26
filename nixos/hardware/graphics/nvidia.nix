{ config, lib, ... }: {
  imports = [ ./intel-only.nix ];
  services.xserver.videoDrivers = ["nvidia"];
  boot.blacklistedKernelModules = [ "nouveau" ];
  # boot.extraModprobeConfig = ''
  # options NVreg_PreserveVideoMemoryAllocations=1
  #  options NVreg_TemporaryFilePath=/tmp
  #'';
  # boot.initrd.kernelModules = [ "nvidia" ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = false;
    #package = config.boot.kernelPackages.nvidiaPackages.beta;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "545.29.02";
      sha256_64bit = "sha256-RncPlaSjhvBFUCOzWdXSE3PAfRPCIrWAXyJMdLPKuIU=";
      sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
      openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
      settingsSha256 = "sha256-zj173HCZJaxAbVV/A2sbJ9IPdT1+3yrwyxD+AQdkSD8=";
      persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
    };
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };
}
