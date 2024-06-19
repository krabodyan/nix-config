{ pkgs, config, lib, ... }:
{
  # programs.sway = {
  #  enable = true;
  #    # };

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    wrapperFeatures.gtk = true;
    xwayland = true;
    config = {
      modifier = "Mod4";
      terminal = "foot";
      startup = [
        { command = "waybar"; }
      ];
      assigns = {
        "workspace 1" = [{ app_id = "^io.github.tdesktop_x64.TDesktop$"; }];
        "workspace 2" = [{ app_id = "^firefox$"; }];
      };

      window.commands = [
        {
          command = "floating enable";
          criteria = {
            app_id = "floaterm";
          };
        }
      ];

      output = {
        "eDP-1" = {
          bg = "${config.background-image} fill";
        };
      };

      #left = "h";
      #right = "j";
      #up = "k";
      #down = "l";

      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 5;
        outer = 3;
      };

      window = {
        border = 2;
        hideEdgeBorders = "smart";
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = false;
        modifier = config.wayland.windowManager.sway.config.modifier;
      };

      fonts = {
        names = [ config.font ];
        style = "Medium";
        size = 10.0;
      };

      focus.followMouse = false;
      seat.seat0.xcursor_theme = "GoogleDot-Blue";

      colors = {
        focused = let
          color = config.colors.accent;
          fields = [ "border" "background" "childBorder" "indicator" "text" ];
        in
          builtins.listToAttrs (map (field: { name = field; value = color; }) fields);

        focusedInactive = let
          color = "ffffff00";
          fields = [ "border" "background" "childBorder" "indicator" "text" ];
        in
          builtins.listToAttrs (map (field: { name = field; value = color; }) fields);

        unfocused = let
          color = "ffffff00";
          fields = [ "border" "background" "childBorder" "indicator" "text" ];
        in
          builtins.listToAttrs (map (field: { name = field; value = color; }) fields);
      };

      input = {
        "*" = {
	        xkb_layout = "us,ru,ua";
	        xkb_options = "grp:alt_shift_toggle";
        };
        "1267:12410:ELAN1203:00_04F3:307A_Touchpad" = {
          events = "disabled";
        };
        "1133:50504:Logitech_USB_Receiver" = {
          accel_profile = "flat";
          pointer_accel = "-1";
        };
	    };

      workspaceLayout = "default";
      bars = [];

      bindkeysToCode = true;
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
        volume     = import ./scripts/volume.nix     { inherit pkgs; };
        gamemode   = import ./scripts/gamemode.nix   { inherit pkgs; };
        touchpad   = import ./scripts/touchpad.nix   { inherit pkgs; };
        microphone = import ./scripts/microphone.nix { inherit pkgs; };
        brightness = import ./scripts/brightness.nix { inherit pkgs; };
      in {
        "${mod}+Return" = "exec ${pkgs.foot}/bin/foot";
        "${mod}+Shift+Return" = "exec ${pkgs.foot}/bin/foot -a floaterm";
        "${mod}+q" = "kill";
        "${mod}+d" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
        "${mod}+Shift+Backspace" = "reload";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Right" = "focus right";
        "${mod}+Up" = "focus up";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Right" = "move right";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Down" = "move down";

        "${mod}+s" = "layout toggle";

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

        #"XF86Display,           exec, ${touchpad}/bin/touchpad";

        "XF86AudioRaiseVolume"  = "exec ${volume}/bin/volume up";
        "XF86AudioLowerVolume"  = "exec ${volume}/bin/volume down";
        "XF86AudioMute"         = "exec ${volume}/bin/volume mute";
        "F4"                    = "exec ${microphone}/bin/microphone";
        "XF86MonBrightnessUp"   = "exec ${brightness}/bin/brightness up";
        "XF86MonBrightnessDown" = "exec ${brightness}/bin/brightness down";

        "${mod}+w" = "exec pkill -SIGUSR1 waybar";
      };
    };
  };
}
