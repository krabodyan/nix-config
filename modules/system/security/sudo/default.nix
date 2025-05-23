{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.security.sudo;
in {
  options = {
    module.security.sudo = {
      enable = mkEnableOption "sudo-rs";
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
        Defaults env_reset,pwfeedback
      '';
      extraRules = [
        {
          groups = ["wheel"];
          commands = map (cmd: {
            command = "/run/current-system/sw/bin/${cmd}";
            options = ["NOPASSWD"];
          }) ["iotop" "iftop" "intel_gpu_top"];
        }
      ];
    };
  };
}
