{
  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "2g";
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  swapDevices = [ ];
}
