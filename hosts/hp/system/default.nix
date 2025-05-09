{hostname, ...}: {
  module = {
    bootloader.enable = true;
    tmpfs.enable = true;
    sound.enable = true;
    nix-config.enable = true;
    time.enable = true;
    console.enable = true;
    users.enable = true;
    locale.enable = true;

    packages = {
      enable = true;
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
      nfs.enable = true;
      k3s-server = {
        enable = true;
        token = "99d12cbd-03d2-4693-bc9b-55ad00c96097";
      };
      sshd.enable = true;
      systemd-config.enable = true;
      earlyoom.enable = false;
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
    };

    graphics = {
      minimal.enable = true;
      intel = {
        enable = true;
        newer = false;
      };
      amdgpu.enable = true;
    };
  };
}
