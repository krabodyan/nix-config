{
  no,
  yes,
  hostname,
  ...
}: {
  module = {
    agenix.enable = true;
    bootloader = yes;
    console = yes;
    locale = yes;
    nix-config = yes;
    sound = yes;
    time = yes;
    tmpfs = yes;
    users = yes;

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
