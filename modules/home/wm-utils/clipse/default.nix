{
  lib,
  pkgs,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.clipse;
in {
  options = {
    module.clipse = {
      enable = mkEnableOption "enable clipse";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.clipse];
    xdg.configFile."clipse/config.json".text = ''
      {
          "allowDuplicates": false,
          "maxHistory": 10,
          "themeFile": "custom_theme.json"
      }
    '';
    xdg.configFile."clipse/custom_theme.json".text = with colors.hex; ''
      {
        "useCustomTheme": true,
        "DimmedDesc": "${surface0}",
        "DimmedTitle": "${surface0}",
        "FilteredMatch": "${magenta}",
        "FilterText": "${fg}",
        "FilterCursor": "${mode_insert}",
        "FilterInfo": "${surface2}",
        "FilterPrompt": "${fg}",
        "NormalTitle": "${fg}",
        "SelectedTitle": "${magenta}",
        "NormalDesc": "${surface0}",
        "SelectedDesc": "${surface0}",
        "SelectedBorder": "${magenta}",
        "SelectedDescBorder": "${magenta}",
        "TitleFore": "${surface0}",
        "TitleInfo": "${surface0}",
        "StatusMsg": "${surface0}",
        "PinIndicatorColor": "${surface0}",
        "PageActiveDot": "${overlay2}",
        "PageInactiveDot": "${surface2}",
        "HelpKey": "${surface0}",
        "HelpDesc": "${surface0}",
        "PreviewedText": "${fg}",
        "PreviewBorder": "${surface2}"
      }
    '';
  };
}
