{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.ssd-btrfs;
in {
  options = {
    module.ssd-btrfs = {
      enable = mkEnableOption "enable btrfs autoscrub and trim";
    };
  };
  config = mkIf cfg.enable {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = ["/"];
    };
    services.fstrim.enable = true;
  };
}
