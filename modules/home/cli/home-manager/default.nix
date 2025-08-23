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
      enable = mkEnableOption "home-manager";
    };
  };
  config = mkIf cfg.enable {
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      inherit stateVersion;
    };

    news.display = "silent";

    programs.man.enable = false;

    manual = {
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };
  };
}
