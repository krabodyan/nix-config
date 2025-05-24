{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.services.getty-autologin;
in {
  options = {
    module.services.getty-autologin = {
      enable = mkEnableOption "getty-autologin";
    };
  };
  config = mkIf cfg.enable {
    services.getty = {
      autologinOnce = true;
      autologinUser = username;
    };
  };
}
