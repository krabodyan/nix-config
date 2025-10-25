{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.viber;
in {
  options = {
    module.viber = {
      enable = mkEnableOption "viber";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.viber];

    xdg.desktopEntries."viber" = {
      name = "Viber Desktop";
      Path = "null";
    };
  };
}
