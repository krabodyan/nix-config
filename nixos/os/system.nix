{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
    systemd-boot.consoleMode = "max";
    timeout = 5;
  };

  documentation = {
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  system.stateVersion = "24.05";
}

