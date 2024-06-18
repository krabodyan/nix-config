{
  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "4g";
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  swapDevices = [ ];
}
