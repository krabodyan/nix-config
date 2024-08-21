{
  pkgs,
  config,
  helpers,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    wrapperFeatures.gtk = true;
    xwayland = true;
    # package = pkgs.swayfx;
    extraConfig = ''
      title_align center
      titlebar_border_thickness 0
      default_border pixel 2
    '';
    #   corner_radius 6
    #   blur disable
    #   shadows disable
    #   default_dim_inactive 0.0
    #   scratchpad_minimize disable
    # '';
    config = {
      modifier = "Mod4";
      terminal = "foot";
      startup = [
        { command = "${pkgs.waybar}/bin/waybar"; }
        { command = "${pkgs.swaykbdd}/bin/swaykbdd"; }
        # { command = "/usr/bin/env QT_QPA_PLATFORMTHEME=gtk3 ${pkgs._64gram}/bin/telegram-desktop"; }
      ];
      assigns = {
        "workspace 1" = [ { app_id = "^org.telegram.desktop$"; } ];
        "workspace 2" = [ { app_id = "^firefox$"; } ];
        "workspace 3" = [ { app_id = "^vesktop$"; } ];
        "workspace 4" = [
          { class = "^steam$"; }
          # { class = "^DesktopEditors$"; }
        ];
        "workspace 6" = [ { app_id = "^(chromium-browser)(.*)$"; } ];
      };

      window.commands = [
        {
          command = "floating enable";
          criteria = {
            app_id = "floaterm";
          };
        }
        {
          command = "border pixel 2";
          criteria = {
            app_id = ".*";
          };
        }
      ];

      output."eDP-1" = {
        bg = "${config.background-image} fill";
        mode = "1920x1080@144.000Hz";
      };

      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 5;
        outer = 0;
      };

      window = {
        hideEdgeBorders = "smart";
        titlebar = false;
      };

      floating = {
        titlebar = false;
        modifier = config.wayland.windowManager.sway.config.modifier;
      };

      fonts = {
        names = [ config.font ];
        style = "Medium";
        size = 10.0;
      };

      focus = {
        followMouse = false;
        wrapping = "yes";
      };

      seat.seat0 = {
        xcursor_theme = "${config.home.pointerCursor.name} ${builtins.toString config.home.pointerCursor.size}";
        hide_cursor = "10000";
      };

      colors =
        with config.colors;
        let
          inherit (helpers) mkHex;
          unfocused = {
            background = mkHex bg-dark;
            border = mkHex border-unfocused;
            childBorder = mkHex border-unfocused;
            indicator = mkHex border-unfocused;
            text = mkHex fg-dark;
          };
          focused = {
            background = mkHex bg + "E6";
            border = mkHex accent;
            childBorder = mkHex accent;
            indicator = mkHex fg;
            text = mkHex fg;
          };
        in
        {
          focused = focused;
          focusedInactive = unfocused;
          unfocused = unfocused;
          urgent = focused;
        };

      input = {
        "type:keyboard" = {
          xkb_layout = "us,ua,ru";
          xkb_options = "ctrl:nocaps,grp:alt_caps_toggle";
          repeat_rate = "35";
          repeat_delay = "400";
        };
        "type:touchpad" = {
          events = "disabled";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
      };

      workspaceLayout = "default";
      bars = [ ];

      bindkeysToCode = true;
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          volume = import ./scripts/volume.nix { inherit pkgs; };
          microphone = import ./scripts/microphone.nix { inherit pkgs; };
          brightness = import ./scripts/brightness.nix { inherit pkgs; };
          screenshot = import ./scripts/screenshot.nix {
            inherit pkgs;
            colors = config.colors;
          };
          left = "h";
          right = "l";
          up = "k";
          down = "j";
        in
        {
          "${mod}+e" = "exec ${pkgs.foot}/bin/foot";
          "${mod}+Shift+e" = "exec ${pkgs.foot}/bin/foot -a floaterm";
          "${mod}+d" = "exec pidof rofi && pkill rofi || ${pkgs.rofi-wayland}/bin/rofi -show drun -kb-cancel 'Alt+Return'";

          "Ctrl+Alt+Backspace" = "reload";
          "Ctrl+Alt+Delete" = "exit";

          "Print" = "exec ${screenshot}/bin/screenshot";
          "Pause" = "exec ${screenshot}/bin/screenshot full";
          "${mod}+Print" = "exec ${screenshot}/bin/screenshot swayimg";
          "${mod}+Shift+Print" = "exec wl-paste | swappy -f -";

          "${mod}+Shift+0" = "exec swaylock";
          "${mod}+w" = "exec pkill -SIGUSR1 waybar";

          "${mod}+${up}" = "focus up";
          "${mod}+${down}" = "focus down";
          "${mod}+${left}" = "focus left";
          "${mod}+${right}" = "focus right";

          "${mod}+Ctrl+${up}" = "move up 20px";
          "${mod}+Ctrl+${down}" = "move down 20px";
          "${mod}+Ctrl+${left}" = "move left 20px";
          "${mod}+Ctrl+${right}" = "move right 20px";

          "${mod}+Shift+${up}" = "resize grow height 20 px";
          "${mod}+Shift+${down}" = "resize shrink height 20 px";
          "${mod}+Shift+${left}" = "resize grow width 20 px";
          "${mod}+Shift+${right}" = "resize shrink width 20 px";

          "${mod}+q" = "kill";
          "${mod}+t" = "fullscreen";
          "${mod}+c" = "layout tabbed";
          "${mod}+s" = "layout toggle";
          "${mod}+f" = "floating toggle";
          "${mod}+Tab" = "focus next";
          "Alt+Tab" = "focus mode_toggle";
          "${mod}+Shift+r" = "splith";
          "${mod}+r" = "splitv";

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

          "${mod}+p" = "output \"eDP-1\" power off";
          "${mod}+Shift+p" = "output \"eDP-1\" power on";

          XF86TouchpadToggle = "input type:touchpad events toggle enabled disabled";
          XF86AudioRaiseVolume = "exec ${volume}/bin/volume up";
          XF86AudioLowerVolume = "exec ${volume}/bin/volume down";
          XF86AudioMute = "exec ${volume}/bin/volume mute";
          F4 = "exec ${microphone}/bin/microphone";
          XF86MonBrightnessUp = "exec ${brightness}/bin/brightness up";
          XF86MonBrightnessDown = "exec ${brightness}/bin/brightness down";
          "${mod}+x" = "exec ${brightness}/bin/brightness toggle";
        };
    };
  };
}
