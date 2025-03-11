{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.bootloader;
in {
  options = {
    module.bootloader = {
      enable = mkEnableOption "Enables Bootloader";
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 12;
      systemd-boot.consoleMode = "max";
      timeout = 8;
    };
  };
}
