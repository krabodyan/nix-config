{
  module = {
    boot.enable = true;
    tmpfs.enable = true;
    ssd-btrfs.enable = true;
    sound.enable = true;
    nix-config.enable = true;

    security = {
      pam.enable = true;
      doas.enable = true;
    };

    services = {
      systemd-config.enable = true;
      earlyoom.enable = true;
      dbus-broker.enable = true;
      docker = {
        enable = true;
        storageDriver = "btrfs";
      };
    };

    networking = {
      dhcpcd = {
        enable = true;
        hostname = "nixos";
      };
      iwd.enable = true;
    };

    graphics = {
      minimal.enable = true;
      intel.enable = true;
      nvidia-hybrid = {
        enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
