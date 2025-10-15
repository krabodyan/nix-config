{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.sc-im;
in {
  options = {
    module.sc-im = {
      enable = mkEnableOption "sc-im";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.sc-im];
    xdg.desktopEntries."sc-im" = {
      name = "SC-IM";
      comment = "Spreadsheet calculator for the terminal";
      exec = "sc-im %F";
      icon = "accessories-calculator";
      terminal = true;
      type = "Application";
      categories = ["Utility" "Office"];
      mimeType = ["text/csv"];
      startupNotify = false;
    };
  };
}
