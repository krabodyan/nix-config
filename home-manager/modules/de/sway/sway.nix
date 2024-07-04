{ pkgs, config, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    wrapperFeatures.gtk = true;
    xwayland = true;
    package = pkgs.swayfx;
    extraConfig = ''
      blur off
      corner_radius 10
      shadows off
      scratchpad_minimize disable
      focus_wrapping force
      popup_during_fullscreen leave_fullscreen
    '';
    config = {
      modifier = "Mod4";
      terminal = "foot";
      startup = [
        { command = "${pkgs.waybar}/bin/waybar"; }
        { command = "${pkgs.swaykbdd}/bin/swaykbdd"; }
        # { command = "/usr/bin/env QT_QPA_PLATFORMTHEME=gtk3 ${pkgs._64gram}/bin/telegram-desktop"; }
      ];
      assigns = {
        "workspace 1" = [{ app_id = "^io.github.tdesktop_x64.TDesktop$"; }];
        "workspace 2" = [{ app_id = "^firefox$"; }];
        "workspace 3" = [{ app_id = "^vesktop$"; }];
        "workspace 4" = [
          { class = "^steam$"; }
          { class = "^DesktopEditors$"; }
        ];
        "workspace 6" = [{ app_id = "^(chromium-browser)(.*)$"; }];
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

      output = {
        "eDP-1" = {
          bg = "${config.background-image} fill";
          mode = "1920x1080@144.000Hz";
        };
      };

      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 8;
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

      focus.followMouse = false;
      seat.seat0 = {
        xcursor_theme = "GoogleDot-Blue";
        hide_cursor = "10000";
      };

      colors = with config.colors;
        let
          mkColor = color: builtins.listToAttrs (map
            (field: {
              name = field;
              value = color;
            })
            [ "border" "background" "childBorder" "indicator" "text" ]
          );
        in
        {
          focused = mkColor accent;
          focusedInactive = mkColor "00000000";
          unfocused = mkColor "00000000";
          urgent = mkColor pink;
        };

      input = {
        "type:keyboard" = {
          xkb_layout = "us,ru,ua";
          xkb_options = "grp:alt_shift_toggle";
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
        in
        {
          "${mod}+Return" = "exec ${pkgs.foot}/bin/foot";
          "${mod}+Shift+Return" = "exec ${pkgs.foot}/bin/foot -a floaterm";
          "${mod}+Shift+e" = "exec ${pkgs.foot}/bin/foot ${pkgs.yazi}/bin/yazi";
          "${mod}+d" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun -normal-window -kb-cancel 'Alt+d'";

          "Ctrl+Alt+Backspace" = "reload";
          "Ctrl+Alt+Delete" = "exit";

          Print = "exec grim -g \"$(slurp -d)\" - | swappy -f -";
          Pause = "exec grim - | swappy -f -";

          "${mod}+l" = "exec swaylock";
          "${mod}+w" = "exec pkill -SIGUSR1 waybar";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Right" = "focus right";
          "${mod}+Up" = "focus up";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Right" = "move right";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Down" = "move down";

          "${mod}+s" = "layout toggle";
          "${mod}+f" = "fullscreen";
          "${mod}+e" = "splitv";
          "${mod}+r" = "splith";
          "${mod}+t" = "floating toggle";
          "${mod}+q" = "kill";

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

          "${mod}+Ctrl+Right" = "resize shrink width 10 px";
          "${mod}+Ctrl+Left" = "resize grow   width 10 px";
          "${mod}+Ctrl+Up" = "resize shrink height 10 px";
          "${mod}+Ctrl+Down" = "resize grow   height 10 px";

          "${mod}+p" = "output \"eDP-1\" power off";
          "${mod}+Shift+p" = "output \"eDP-1\" power on";

          XF86TouchpadToggle = "input type:touchpad events toggle enabled disabled";
          XF86AudioRaiseVolume = "exec ${volume}/bin/volume up";
          XF86AudioLowerVolume = "exec ${volume}/bin/volume down";
          XF86AudioMute = "exec ${volume}/bin/volume mute";
          F4 = "exec ${microphone}/bin/microphone";
          XF86MonBrightnessUp = "exec ${brightness}/bin/brightness up";
          XF86MonBrightnessDown = "exec ${brightness}/bin/brightness down";
        };
    };
  };
}
