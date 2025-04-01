{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.security.sudo;
in {
  options = {
    module.security.sudo = {
      enable = mkEnableOption "enable sudo-rs";
    };
  };
  config = mkIf cfg.enable {
    security.sudo.enable = false;
    security.sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
      defaultOptions = [
        "SETENV"
      ];
      extraConfig = ''
        Defaults pwfeedback
      '';
      extraRules = [
        {
          groups = ["wheel"];
          commands = [
            {
              command = lib.getExe' pkgs.intel-gpu-tools "intel_gpu_top";
              options = ["NOPASSWD"];
            }
            {
              command = lib.getExe' pkgs.iftop;
              options = ["NOPASSWD"];
            }
            {
              command = lib.getExe' pkgs.iotop;
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
    };
  };
}
