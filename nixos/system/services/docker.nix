{ lib, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  systemd.services.docker.wantedBy = lib.mkForce [ ];
  systemd.sockets.docker.wantedBy = lib.mkForce [ ];
}
