{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.zram;
in {
  options = {
    module.zram = {
      enable = mkEnableOption "enable zram for /tmp and swap with sysctl vm options";
    };
  };
  config = mkIf cfg.enable {
    boot.tmp = {
      useZram = true;
      zramSettings = {
        zram-size = "ram / 2";
      };
    };
    zramSwap = {
      enable = true;
      algorithm = "lz4";
      memoryPercent = 60;
    };
    boot.kernel.sysctl = {
      "vm.swappiness" = 40;
      "vm.page-cluster" = 0;
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 15;
      "vm.vfs_cache_pressure" = 50;
    };
  };
}
