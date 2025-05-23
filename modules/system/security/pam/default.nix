{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.security.pam;
in {
  options = {
    module.security.pam = {
      enable = mkEnableOption "pam settigs";
    };
  };
  config = mkIf cfg.enable {
    security.pam.loginLimits = [
      {
        domain = "${username}";
        type = "soft";
        item = "core";
        value = "unlimited";
      }
    ];
    security.pam.services.swaylock = {};
  };
}
