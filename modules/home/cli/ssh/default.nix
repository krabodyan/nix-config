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
        jetson2 = {
          hostname = "10.0.3.165";
          user = "firefly";
          port = 22;
        };
        jetson3 = {
          hostname = "10.0.3.164";
          user = "firefly";
          port = 22;
        };
      };
    };
  };
}
