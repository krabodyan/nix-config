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
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "570.133.07";
        sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
        openSha256 = "sha256-9l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
        settingsSha256 = "sha256-XMk+FvTlGpMquM8aE8kgYK2PIEszUZD2+Zmj2OpYrzU=";
        usePersistenced = false;
      };
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
