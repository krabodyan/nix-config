{
  hostname,
  yes,
  ...
}: {
  module = {
    bootloader = yes;
    tmpfs = yes;
    sound = yes;
    nix-config = yes;
    time = yes;
    console = yes;
    users = yes;
    locale = yes;

    packages = {
      enable = true;
      fonts = yes;
    };

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
      nfs = yes;
      k3s-server = {
        enable = true;
        token = "99d12cbd-03d2-4693-bc9b-55ad00c96097";
      };
      sshd = yes;
      systemd-config = yes;
      earlyoom.enable = false;
      dbus-broker = yes;
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
      minimal = yes;
      intel = {
        enable = true;
        newer = false;
      };
      amdgpu = yes;
    };
  };
}
