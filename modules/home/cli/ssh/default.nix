{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.ssh;
in {
  options = {
    module.ssh = {
      enable = mkEnableOption "ssh";
    };
  };
  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        jetson = {
          hostname = "10.0.3.166";
          user = "firefly";
          port = 22;
        };
        microhard = {
          hostname = "192.168.168.170";
          user = "firefly";
          port = 22;
        };
      };
    };
  };
}
