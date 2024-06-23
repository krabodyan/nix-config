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
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
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
