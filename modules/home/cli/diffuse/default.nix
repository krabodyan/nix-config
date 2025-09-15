{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.diffuse;
in {
  options = {
    module.diffuse = {
      enable = mkEnableOption "diffuse";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.diffuse];

    programs.git.extraConfig = {
      merge.tool = "diffuse";
      mergetool = {
        prompt = false;
        keepBackup = false;
        keepTemporaries = false;
      };
    };

    xdg.configFile."diffuse/prefs".text = ''
      align_ignore_case True
      display_font "IosevkaTerm Nerd Font Medium 14"
      display_ignore_blanklines True
      display_show_right_margin False
      display_tab_width 4
      editor_soft_tab_width 4
      encoding_default_codec "utf_8"
    '';
  };
}
