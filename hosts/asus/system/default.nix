{
  pkgs,
  hostname,
  ...
}: {
  module = {
    bluetooth.enable = true;
    bootloader.enable = true;
    tmpfs.enable = true;
    ssd-btrfs.enable = true;
    sound.enable = true;
    nix-config.enable = true;
    time.enable = true;
    console.enable = true;
    users.enable = true;
    udev-rules = {
      enable = true;
      platformio = true;
    };
    locale.enable = true;

    packages = {
      enable = true;
      steam = true;
      extraPackages = with pkgs; [
        imagemagick
      ];
      fonts.enable = true;
    };

    xdg-portal = {
      enable = true;
      terminal = "foot.desktop";
      portals = ["gtk" "wlr"];
    };

    security = {
      pam.enable = true;
      sudo.enable = true;
    };

    services = {
      tlp = {
        enable = true;
        enableDaemon = false;
      };
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
        inherit hostname;
      };
      iwd = {
        enable = true;
        enableDaemon = false;
      };
    };

    graphics = {
      minimal.enable = true;
      intel = {
        enable = true;
        newer = true;
      };
      nvidia-hybrid = {
        enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
