{
  lib,
  pkgs,
  fonts,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.meld;
in {
  options = {
    module.meld = {
      enable = mkEnableOption "meld";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.meld];

    programs.git.extraConfig = {
      merge.tool = "meld";
    };

    dconf.settings."org/gnome/meld" = {
      custom-font = "${fonts.monospace} Medium 10";
      enable-space-drawer = false;
      highlight-current-line = true;
      highlight-syntax = true;
      indent-width = 4;
      prefer-dark-theme = true;
      show-line-numbers = false;
      show-overview-map = true;
      style-scheme = "cobalt";
      use-system-editor = true;
      use-system-font = false;
      vc-commit-margin = 75;
      wrap-mode = "none";
    };
  };
}
