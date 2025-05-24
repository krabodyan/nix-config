{
  no,
  yes,
  hostname,
  ...
}: {
  module = {
    agenix.enable = true;
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
      dbus-broker = yes;
      docker = yes;
      earlyoom = yes;
      getty-autologin = no;
      sshd = yes;
      systemd-config = no;
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
