{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.services.sshd;
in {
  options = {
    module.services.sshd = {
      enable = mkEnableOption "enables sshd";
      enableDaemon = mkOption {
        type = lib.types.bool;
        example = true;
      };
    };
  };
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.AllowUsers = [username];
    };
  };
}
