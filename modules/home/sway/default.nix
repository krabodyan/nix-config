{
  lib,
  pkgs,
  fonts,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.sway;
in {
  options = {
    module.sway = {
      enable = mkEnableOption "enable sway wm";
      background = mkOption {
        type = lib.types.str;
      };
      menu = mkOption {
        type = lib.types.enum ["rofi" "fuzzel"];
      };
      extraConfig = mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
  config = mkIf cfg.enable {
    home.sessionVariables = {
      XDG_SESSION_DESKTOP = "sway";
      XDG_CURRENT_DESKTOP = "sway";
    };
    wayland.windowManager.sway = {
      enable = true;
      checkConfig = false;
      wrapperFeatures = {
        gtk = true;
        base = true;
      };
      xwayland = true;
      systemd.xdgAutostart = false;
      systemd.extraCommands = [
        "systemctl --user reset-failed"
        "systemctl --user start sway-session.target"
        "dbus-update-activation-environment --systemd --all"
        "swaymsg -mt subscribe '[]' || true"
        "systemctl --user stop sway-session.target"
      ];
      config = {
        modifier = "Mod4";
        terminal = "foot";

        startup = [
          {command = "${pkgs.swaykbdd}/bin/swaykbdd -a firefox,chrome,firefox-nightly &";}
          {command = "wl-clip-persist --clipboard regular &";}
        ];

        assigns = {
          "workspace 1" = [
            {app_id = "^org.telegram.desktop$";}
          ];
          "workspace 2" = [
            {app_id = "^firefox$";}
            {app_id = "^firefox-nightly$";}
          ];
          "workspace 3" = [
            {app_id = "^vesktop$";}
          ];
          "workspace 4" = [
            {class = "^zoom$";}
          ];
          "workspace 5" = [
            {class = "^ONLYOFFICE$";}
            {class = "^steam$";}
          ];
        };

        window.commands = [
          {
            command = "floating enable; resize set 1000 px 800 px";
            criteria.app_id = "xdg-desktop-portal-gtk";
          }
          {
            command = "floating enable";
            criteria.app_id = "floaterm";
          }
          {
            command = "floating enable";
            criteria.class = "zoom";
          }
          {
            command = "border pixel 2";
            criteria.app_id = ".*";
          }
        ];

        output."eDP-1" = {
          bg = "${cfg.background} fill";
          mode = "1920x1080@144.000Hz";
        };

        gaps = {
          inner = 0;
          outer = 0;
          smartGaps = true;
          smartBorders = "on";
        };

        window = {
          titlebar = false;
          hideEdgeBorders = "smart";
        };

        floating = {
          titlebar = false;
          modifier = config.wayland.windowManager.sway.config.modifier;
        };

        fonts = {
          names = [fonts.monospace];
          style = "SemiBold";
          size = 12.0;
        };

        focus = {
          followMouse = false;
          wrapping = "yes";
        };

        seat.seat0 = {
          xcursor_theme = "${config.home.pointerCursor.name} ${
            builtins.toString config.home.pointerCursor.size
          }";
          hide_cursor = "5000";
        };

        colors = with colors.hex; let
          unfocused = {
            background = bg;
            border = bg;
            childBorder = bg;
            indicator = bg;
            text = overlay0;
          };
          focused = {
            background = bg;
            border = bg;
            childBorder = border;
            indicator = border;
            text = subtext0;
          };
        in {
          focused = focused;
          focusedInactive = unfocused;
          unfocused = unfocused;
          urgent = focused;
        };

        input = {
          "type:keyboard" = {
            xkb_layout = "us,ua,ru";
            xkb_options = "grp:alts_toggle,caps:backspace,shift:both_capslock";
            repeat_rate = "40";
            repeat_delay = "400";
          };
          "type:touchpad" = {
            events = "disabled";
            dwt = "enabled";
            tap = "enabled";
            natural_scroll = "enabled";
          };
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0";
          };
        };

        bars = [];

        workspaceLayout = "default";
        workspaceAutoBackAndForth = false;

        workspaceOutputAssign = [
          {
            workspace = "8";
            output = "HDMI-A-1";
          }
        ];

        bindkeysToCode = true;

        keybindings = let
          mod = config.wayland.windowManager.sway.config.modifier;

          menucmd =
            if cfg.menu == "fuzzel"
            then "pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"
            else if cfg.menu == "rofi"
            then "pkill rofi || ${pkgs.rofi-wayland-unwrapped}/bin/rofi -show drun -kb-cancel 'Alt+Return'"
            else throw "unexpected menu";

          up = "k";
          down = "j";
          left = "h";
          right = "l";
        in {
          "${mod}+d" = "exec ${menucmd}";
          "${mod}+e" = "exec ${pkgs.foot}/bin/foot";
          "${mod}+Shift+e" = "exec ${pkgs.foot}/bin/foot -a floaterm";
          "${mod}+r" = "exec ${pkgs.foot}/bin/foot -a floaterm pulsemixer";
          "${mod}+c" = ''exec notify-send --expire-time 2000 "$(date +"%d %B %H:%M")"'';

          "${mod}+Alt+b" = "seat seat0 hide_cursor 0";
          "${mod}+w" = "input type:keyboard xkb_switch_layout 0";
          "${mod}+b" = "seat seat0 hide_cursor ${config.wayland.windowManager.sway.config.seat.seat0.hide_cursor}";

          "${mod}+Shift+Delete" = "exit";

          "${mod}+Shift+0" = "exec swaylock";

          "${mod}+${up}" = "focus up";
          "${mod}+${down}" = "focus down";
          "${mod}+${left}" = "focus left";
          "${mod}+${right}" = "focus right";

          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${right}" = "move right";

          "${mod}+i" = "resize grow width 20 px";
          "${mod}+o" = "resize shrink width 20 px";

          "${mod}+q" = "kill";
          "${mod}+t" = "fullscreen";
          "${mod}+f" = "floating toggle";

          "${mod}+s" = "layout toggle tabbed splith";
          "${mod}+v" = "layout toggle splith splitv";

          "${mod}+space" = "focus next";
          "Alt+Shift+Tab" = "focus mode_toggle";
          "${mod}+Tab" = "workspace back_and_forth";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";

          "${mod}+x" = "exec __brightness toggle";

          XF86AudioMute = "exec __volume mute";
          XF86AudioRaiseVolume = "exec __volume up";
          XF86AudioLowerVolume = "exec __volume down";
          XF86MonBrightnessUp = "exec __brightness up";
          XF86MonBrightnessDown = "exec __brightness down";
          XF86TouchpadToggle = "exec __touchpad";

          F4 = "exec __microphone";
          Print = "exec __screenshot";
          Pause = "exec __screenshot full";

          "${mod}+Print" = "exec __screenshot swayimg";
          "${mod}+Shift+Print" = "exec wl-paste | swappy -f -";
        };
      };

      extraConfig = ''
        title_align center
        titlebar_border_thickness 0
        default_border pixel 2
        default_floating_border pixel 2
        focus_wrapping workspace
      '';
    };
  };
}
