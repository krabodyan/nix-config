{ pkgs, config, lib, ... }:
{
  xdg = {
    enable = true;
    userDirs.enable = true;
    mimeApps.enable = true;
    configFile."mimeapps.list".force = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
    MOZ_ENABLE_WAYLAND = 1;
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = 1;
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Sway";
    XDG_SCREENSHOTS_DIR = "~/pictures";
    WLR_RENDERER = "vulkan";
    #"WLR_RENDERER_ALLOW_SOFTWARE,1"
    WLR_DRM_NO_ATOMIC = 1;
    #"__GL_VRR_ALLOWED,0"
    __GL_THREADED_OPTIMIZATIONS = 1;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

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
        "workspace 3" = [{ app_id = "^vesktop$"; }];
        "workspace 4" = [
          { class = "^steam$"; }
          { class = "^DesktopEditors$"; }
        ];
        "workspace 7" = [{ app_id = "^chromium-browser.*$"; }];
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
        };
      };

      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 8;
        outer = 0;
      };

      window = {
        # border = 2;
        hideEdgeBorders = "smart";
        titlebar = false;
      };

      floating = {
        # border = 2;
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
          color = config.colors.bg;
          fields = [ "border" "background" "childBorder" "indicator" "text" ];
        in
          builtins.listToAttrs (map (field: { name = field; value = color; }) fields);

        unfocused = let
          color = config.colors.bg;
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

        "Print" = "exec grim -g \"$(slurp -d)\" - | wl-copy -t image/png";
        "F12"   = "exec grim - | wl-copy -t image/png";

        "${mod}+w" = "exec pkill -SIGUSR1 waybar";
      };
    };
  };
}
