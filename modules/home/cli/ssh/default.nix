{
  lib,
  pkgs,
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
    home.packages = [pkgs.sshfs];
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          serverAliveInterval = 60;
          serverAliveCountMax = 20;
          port = 22;
          extraOptions = {
            strictHostKeyChecking = "no";
          };
        };
        jetson = {
          hostname = "10.0.3.166";
          user = "firefly";
        };
        jetson2 = {
          hostname = "10.0.3.163";
          user = "firefly";
        };
        jetson3 = {
          hostname = "10.0.3.164";
          user = "firefly";
        };
        prague = {
          hostname = "10.0.9.128";
          user = "nvidia";
        };
      };
    };
  };
}
