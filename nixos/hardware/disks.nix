{
  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "6g";
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };

  services.fstrim.enable = true;

  swapDevices = [];
}
