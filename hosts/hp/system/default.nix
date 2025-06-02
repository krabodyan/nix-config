{yes, ...}: {
  module = {
    agenix = yes;
    bootloader = yes;
    console = yes;
    locale = yes;
    nix-config = yes;
    sound = yes;
    time = yes;
    tmpfs = yes;
    users = yes;

    packages = yes;
    fonts = yes;

    xdg-portal = {
      enable = true;
      terminal = "foot.desktop";
      portals = ["gtk" "wlr"];
    };

    security = {
      pam = yes;
      sudo = yes;
    };

    services = {
      dbus-broker = yes;
      docker = yes;
      earlyoom = yes;
      getty-autologin = yes;
      sshd = yes;
      systemd-config = yes;
    };

    networking = {
      dhcpcd = yes;
      # iwd = {
      #   enable = true;
      #   enableDaemon = true;
      # };
    };

    graphics = {
      minimal = yes;
      intel = {
        enable = true;
        newer = false;
      };
      amdgpu = yes;
    };
  };
}
