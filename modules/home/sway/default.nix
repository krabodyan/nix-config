{
  lib,
  pkgs,
  hidpi,
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
      enable = mkEnableOption "sway wm";
      background = mkOption {
        type = lib.types.str;
      };
      menu = mkOption {
        type = lib.types.enum ["rofi" "fuzzel"];
        example = "rofi";
      };
      screenshot = mkOption {
        type = lib.types.enum ["swappy" "satty"];
        example = "swappy";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
    ];

    home.sessionVariables = {
      XDG_SESSION_DESKTOP = "sway";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
    };

    wayland.systemd.target = "sway-session.target";
    wayland.windowManager.sway = {
      enable = true;
      xwayland = true;
      checkConfig = false;
      wrapperFeatures = {
        gtk = true;
        base = true;
      };
      systemd = {
        xdgAutostart = false;
        dbusImplementation = "broker";
        extraCommands = [
          "systemctl --user reset-failed"
          "systemctl --user start sway-session.target"
          "dbus-update-activation-environment --systemd --all"
          "swaymsg -mt subscribe '[]' || true"
          "systemctl --user stop sway-session.target"
        ];
      };
      config = let
        mod = "Mod4";
        hideCursor = "5000";
        resetLayout = "input type:keyboard xkb_switch_layout 0";

        menuCmd =
          {
            fuzzel = "pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel";
            rofi = "pkill rofi || ${pkgs.rofi-wayland-unwrapped}/bin/rofi -show drun -kb-cancel 'Alt+Return'";
          }.${
            cfg.menu
          };

        screenshotCmd =
          {
            swappy = "${lib.getExe pkgs.swappy} -f -";
            satty = "${lib.getExe pkgs.satty} -f -";
          }.${
            cfg.screenshot
          };

        terminalCmd = "${pkgs.foot}/bin/footclient";
      in {
        modifier = mod;
        terminal = terminalCmd;

        startup = with pkgs;
          map (cmd: {command = cmd;}) [
            "${lib.getExe swaykbdd} -a 'firefox,chrome,firefox-nightly'"
            "${lib.getExe wl-clip-persist} --clipboard regular --disable-timestamps --reconnect-tries 3"
            "${lib.getExe foot} --server"
          ];

        assigns = {
          "workspace 1" = [
            {app_id = "^org\.telegram\.desktop$";}
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
            {class = "^steam$";}
          ];
          "workspace 5" = [
            {class = "^ONLYOFFICE$";}
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
            command = "border pixel 1";
            criteria.app_id = ".*";
          }
        ];

        output = {
          "eDP-1" = {
            bg = "${cfg.background} fill";
            scale = "1";
          };
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
          modifier = mod;
        };

        fonts = {
          names = [fonts.monospace];
          style = "SemiBold";
          size =
            if hidpi
            then 13.0
            else 11.0;
        };

        focus = {
          followMouse = false;
          wrapping = "workspace";
        };

        seat.seat0 = {
          hide_cursor = hideCursor;
        };

        colors = with colors.hex; let
          unfocused = {
            background = bg;
            border = bg;
            childBorder = bg;
            indicator = bg;
            text = surface3;
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
            xkb_layout = "us,ru,ua";
            xkb_options = "grp:alts_toggle,caps:backspace,shift:both_capslock";
            repeat_rate = "40";
            repeat_delay = "400";
          };

          "type:touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            tap_button_map = "lrm";
            accel_profile = "flat";
            pointer_accel = "0.5";
            natural_scroll = "disabled";
            events =
              if hidpi
              then "enabled"
              else "disabled";
          };

          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0";
          };
        };

        bars = [];

        workspaceLayout = "default";
        workspaceAutoBackAndForth = false;

        workspaceOutputAssign =
          (
            map (num: {
              workspace = toString num;
              output = "eDP-1";
            }) [1 2 3 4 5 6 7]
          )
          ++ [
            {
              workspace = "8";
              output = "HDMI-A-1";
            }
          ];

        bindkeysToCode = true;

        modes = {
          resize = {
            "${mod}+Shift+o" = "exec makoctl dismiss & swaymsg mode default";
            Escape = "exec makoctl dismiss & swaymsg mode default";
            Return = "exec makoctl dismiss & swaymsg mode default";
            h = "resize grow width 20 px";
            k = "resize grow height 20 px";
            l = "resize shrink width 20 px";
            j = "resize shrink height 20 px";
          };
        };

        keybindings = {
          "${mod}+Shift+o" = "exec notify-send -a swaynotify -t 0 'mode resize' & swaymsg mode resize";

          "${mod}+d" = "exec swaymsg ${resetLayout} & ${menuCmd}";
          "${mod}+e" = "exec ${terminalCmd}";
          "${mod}+Shift+r" = "exec ${terminalCmd} -a floaterm ${lib.getExe pkgs.pulsemixer}";
          "${mod}+Shift+e" = "exec ${terminalCmd} -a floaterm";

          "${mod}+c" = ''exec notify-send -t 2000 "$(date +"%d %B %H:%M")"'';

          "${mod}+b" = "seat seat0 hide_cursor ${hideCursor}";
          "${mod}+Alt+b" = "seat seat0 hide_cursor 0";

          "${mod}+w" = resetLayout;

          "${mod}+Shift+Delete" = "exit";

          "${mod}+Shift+0" = "exec swaylock";

          "${mod}+k" = "focus up";
          "${mod}+j" = "focus down";
          "${mod}+h" = "focus left";
          "${mod}+l" = "focus right";

          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+l" = "move right";

          "${mod}+q" = "kill";
          "${mod}+t" = "fullscreen";
          "${mod}+f" = "floating toggle";

          "${mod}+s" = "layout toggle tabbed splith";
          "${mod}+a" = "layout toggle splith splitv";

          "${mod}+Tab" = "workspace back_and_forth";
          "${mod}+space" = "focus next";
          "${mod}+Shift+Tab" = "focus mode_toggle";

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

          F4 = "exec __microphone";
          XF86AudioMute = "exec __volume mute";
          XF86AudioRaiseVolume = "exec __volume up";
          XF86AudioLowerVolume = "exec __volume down";
          XF86MonBrightnessUp = "exec __brightness up";
          XF86MonBrightnessDown = "exec __brightness down";
          XF86TouchpadToggle = "exec __touchpad";

          "${mod}+x" = "exec __brightness toggle";
          "${mod}+F10" = "exec __touchpad";

          Print = "exec __screenshot";
          Pause = "exec __screenshot full";
          F10 = "exec __screenshot full";
          "${mod}+Pause" = "exec __screenshot swayimg";
          "${mod}+Shift+Print" = "exec wl-paste | ${screenshotCmd}";
        };
      };

      extraConfigEarly =
        # sway
        ''
          title_align center
          titlebar_border_thickness 0
          titlebar_padding 0

          default_border pixel 1
          default_floating_border pixel 1

          bindswitch lid:on exec swaylock
        '';
    };
  };
}
