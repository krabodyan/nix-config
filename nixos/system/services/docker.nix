{ lib, ... }: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    storageDriver = "btrfs";
  };
  systemd.services.docker.wantedBy = lib.mkForce [ ];
  systemd.sockets.docker.wantedBy = lib.mkForce [ ];
}
