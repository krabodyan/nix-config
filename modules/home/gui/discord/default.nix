{
  lib,
  pkgs,
  config,
  systemFont,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.discord;
in {
  options = {
    module.discord = {
      enable = mkEnableOption "enable discord";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.vesktop];
    xdg.configFile."vesktop/settings/quickCss.css".text = ''
      * {
        font-family: "${systemFont}" !important;
        font-weight: bold !important;
        font-size: 15px !important;
      }
    '';
  };
}
