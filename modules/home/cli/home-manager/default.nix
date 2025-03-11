{
  lib,
  config,
  username,
  stateVersion,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.home-manager;
in {
  options = {
    module.home-manager = {
      enable = mkEnableOption "enables home-manager";
    };
  };
  config = mkIf cfg.enable {
    home = {
      username = "${username}";
      homeDirectory = "/home/${username}";
      inherit stateVersion;
    };
    programs.home-manager.enable = true;
    news.display = "silent";
  };
}
