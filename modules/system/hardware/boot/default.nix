{
  imports = [./kernel.nix];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 12;
    systemd-boot.consoleMode = "max";
    timeout = 8;
  };
}
