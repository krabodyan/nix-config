{ pkgs, config, ... }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  wayland.windowManager.sway = {
    enable = true;
      modifier = "Mod4";
      terminal = "foot";
      startup = [
        {command = "waybar";}
      ];
      assigns = [];
      left = "h";
      right = "j";
      up = "k";
      down = "l";

      gaps = {
        smartBorders = "on";
        inner = 5;
        outer = 12;
      };

      window.border = 2;
      window.hideEdgeBorders = "smart";
      floating.border = 2;

      fonts = "pango:JetBrainsMono 10"

      focus.followMouse = false;
      seat.seat0.xcursor_theme = "GoogleDot-Blue";

      colors = {
        focused.border = config.colors.accent;
        #focusedInactive.border = config.colors.bg;
        #unfocused.border = config.colors.
      };

      input."*" = {
	      xkb_layout = "us,ru";
	      xkb_options = "grp:alt_shift_toggle";
	    }

      bindkeysToCode = true;
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+Return" = "exec ${pkgs.foot}/bin/foot";
        "${mod}+q" = "kill";
        "${mod}+d" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
        "${mod}+Shift+Backspace" = "reload";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Right" = "focus right";
        "${mod}+Up" = "focus up";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Right" = "move right"
        "${mod}+Shift+Up" = "move up"
        "${mod}+Shift+Down" = "move down";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
      }
    };
  };
}
