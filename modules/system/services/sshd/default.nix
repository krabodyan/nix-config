{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.services.sshd;
in {
  options = {
    module.services.sshd = {
      enable = mkEnableOption "enables sshd";
    };
  };
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.AllowUsers = [username];
    };
  };
}
