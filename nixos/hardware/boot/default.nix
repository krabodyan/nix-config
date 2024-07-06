{
  self,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./kernel.nix ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
    systemd-boot.consoleMode = "max";
    timeout = 8;
  };
  system.nixos.label = ":D";
}
