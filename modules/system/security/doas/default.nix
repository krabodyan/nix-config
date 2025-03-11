{
  lib,
  pkgs,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.security.doas;
in {
  options = {
    module.security.doas = {
      enable = mkEnableOption "enable doas";
    };
  };
  config = mkIf cfg.enable {
    security.sudo.enable = false;
    environment.systemPackages = [pkgs.doas-sudo-shim];
    security.doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          noPass = false;
          keepEnv = true;
          persist = true;
        }
        {
          users = ["${username}"];
          cmd = "intel_gpu_top";
          noPass = true;
        }
        {
          users = ["${username}"];
          cmd = "iotop";
          noPass = true;
        }
        {
          users = ["${username}"];
          cmd = "iftop";
          noPass = true;
        }
      ];
    };
  };
}
