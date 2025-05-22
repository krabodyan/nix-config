{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.graphics.nvidia-hybrid;
in {
  options = {
    module.graphics.nvidia-hybrid = {
      enable = mkEnableOption "enable nvidia hybrid gpu";
      intelBusId = mkOption {
        type = lib.types.str;
        example = "PCI:0:2:0";
      };
      nvidiaBusId = mkOption {
        type = lib.types.str;
        example = "PCI:1:0:0";
      };
    };
  };
  config = mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];
    boot.blacklistedKernelModules = ["nouveau"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      nvidiaSettings = false;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        inherit (cfg) intelBusId nvidiaBusId;
      };
    };
  };
}
