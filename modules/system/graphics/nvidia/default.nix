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
      enable = mkEnableOption "nvidia hybrid gpu";
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
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "570.181";
        sha256_64bit = "sha256-8G0lzj8YAupQetpLXcRrPCyLOFA9tvaPPvAWurjj3Pk=";
        sha256_aarch64 = "sha256-1pUDdSm45uIhg0HEhfhak9XT/IE/XUVbdtrcpabZ3KU=";
        openSha256 = "sha256-U/uqAhf83W/mns/7b2cU26B7JRMoBfQ3V6HiYEI5J48=";
        settingsSha256 = "sha256-iBx/X3c+1NSNmG+11xvGyvxYSMbVprijpzySFeQVBzs=";
        persistencedSha256 = "sha256-RoAcutBf5dTKdAfkxDPtMsktFVQt5uPIPtkAkboQwcQ=";
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
