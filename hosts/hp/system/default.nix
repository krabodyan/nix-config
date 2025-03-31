{hostname, ...}: {
  module = {
    bootloader.enable = true;
    tmpfs.enable = true;
    sound.enable = true;
    nix-config.enable = true;
    time.enable = true;
    docs.enable = true;
    console.enable = true;
    users.enable = true;
    udev-rules = {
      enable = true;
    };
    locale.enable = true;

    packages = {
      enable = true;
      fonts = {
        enable = true;
        serif = "Roboto Medium";
      };
    };

    xdg-portal = {
      enable = true;
      terminal = "foot.desktop";
      portals = ["gtk" "wlr"];
    };

    security = {
      pam.enable = true;
      doas.enable = true;
    };

    services = {
      tlp = {
        enable = true;
        enableDaemon = false;
      };
      sshd.enable = true;
      systemd-config.enable = true;
      earlyoom.enable = true;
      dbus-broker.enable = true;
      docker = {
        enable = true;
      };
    };

    networking = {
      dhcpcd = {
        enable = true;
        inherit hostname;
      };
      iwd = {
        enable = true;
        enableDaemon = true;
      };
    };

    graphics = {
      minimal.enable = true;
      intel.enable = true;
    };
  };
}
