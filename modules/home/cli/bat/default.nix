{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.bat;
in {
  options = {
    module.bat = {
      enable = mkEnableOption "enable bat";
    };
  };
  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "theme";
        style = "numbers,grid,changes";
      };
    };
    xdg.configFile."bat/themes/theme.tmTheme".source = ./theme.tmTheme;
  };
}
