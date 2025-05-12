{
  lib,
  fonts,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.fuzzel;
in {
  options = {
    module.fuzzel = {
      enable = mkEnableOption "enable fuzzel";
    };
  };
  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "${fonts.monospace}:size=11:weight=Regular";
          exit-on-keyboard-focus-loss = true;
          terminal = "foot -e";
          prompt = "\"> \"";
          layer = "overlay";
          icons-enabled = false;
          filter-desktop = true;
          fields = "name";
          match-mode = "fzf";
          anchor = "bottom";
          y-margin = "20";
          lines = "3";
          horizontal-pad = "10";
          vertical-pad = "10";
          inner-pad = "5";
        };
        border = {
          width = 1;
          radius = 0;
        };

        dmenu = {
          exit-immediately-if-empty = true;
        };

        key-bindings = {
          next = "Mod1+j";
          prev = "Mod1+k";
        };

        colors = with colors;
          builtins.mapAttrs (name: value: "${value}ff") {
            selection = bg;
            background = bg;

            input = fg;
            match = fg;
            selection-text = fg;
            selection-match = fg;

            text = fg-dark;

            prompt = overlay0;
            border = overlay0;
          };
      };
    };
  };
}
