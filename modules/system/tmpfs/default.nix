{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.tmpfs;
in {
  options = {
    module.tmpfs = {
      enable = mkEnableOption "/tmp in tmpfs";
    };
  };
  config = mkIf cfg.enable {
    boot.tmp = {
      useTmpfs = true;
      tmpfsSize = "10g";
    };
  };
}
