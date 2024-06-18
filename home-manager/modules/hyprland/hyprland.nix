{ pkgs, config, inputs, ... }:
{
    xdg = {
      enable = true;
      userDirs.enable = true;
      mimeApps.enable = true;
      configFile = {
        "mimeapps.list".force = true;
      };
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        config.common.default = "*";
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-gtk
        ];
      };
    };
    # home.packages = [ pkgs.xdg-terminal-exec ];

    wayland.windowManager.hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland = {
        enable = true;
      };

      settings = {
        "$mainMod" = "SUPER";
        source = "$HOME/nix-config/home-manager/modules/misc/touchpad.conf";
        monitor = "eDP-1,preferred,auto,1";

        env = [
          "WLR_NO_HARDWARE_CURSORS, 1"
          #"QT_QPA_PLATFORMTHEME,qt5ct"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "QT_QPA_PLATFORM,wayland"
          "XDG_SCREENSHOTS_DIR,~/pictures"
          #"WLR_RENDERER,vulkan"
          "WLR_RENDERER_ALLOW_SOFTWARE,1"
          "WLR_DRM_NO_ATOMIC,1"
          #"__GL_VRR_ALLOWED,1"
          #"__GL_THREADED_OPTIMIZATIONS,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "GDK_BACKEND,wayland"
          "MOZ_ENABLE_WAYLAND,1"
        ];

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        kb_layout = "us,ru,ua";
        kb_variant = "lang";
        kb_options = "grp:alt_shift_toggle";

        repeat_rate = 35;
        repeat_delay = 400;

        follow_mouse = 2;
        float_switch_override_focus = false;

        numlock_by_default = false;
        force_no_accel = true;

        sensitivity = -0.9;

        touchpad = {
          scroll_factor = 0.3;
        };
      };

      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
        resize_on_border = false;
        no_cursor_warps = true;
        allow_tearing = false;
        cursor_inactive_timeout = 5;
        #"col.active_border" = "0xffD74B5C 0xffe5678b 90deg";
        "col.active_border" = "0xff${config.colors.accent}";
        "col.inactive_border" = "0x00${config.colors.bg}";
      };

      opengl = {
        force_introspection = 1;
      };

      decoration = {
        rounding = 12;

        blur = {
          enabled = false;
          size = 10;
          passes = 3;
          xray = true;
          ignore_opacity = true;
          new_optimizations = true;
        };

        dim_inactive = false;
        #dim_strength = 0.2;
        #dim_special = 0;
        drop_shadow = false;
        # shadow_range = 30;
        # shadow_render_power = 3;
        # "col.shadow" = "0x66000000";
      };

      layerrule = [
        # "animation slide bottom, ^(rofi)$"
        #"noanim, waybar"
        #"noanim, wallpaper"
        # "blur, waybar"
        # "ignorezero, waybar"
        #"blur, notifications"
        #"ignorezero, notifications"
        #"blur, rofi"
        #"ignorezero, rofi"
      ];

      animations = {
        enabled = true;
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "overshot, 0.1, 1.1, 0.1, 1.032"
        ];
        animation = [
          "layersIn,    1, 2,    default, fade"
          "layersOut,   1, 2,    default, fade"

          "windows,     1, 3,    overshot, slide"
          "windowsOut,  0, 3,    md3_decel, slide"
          "border,      0, 7,    md3_decel"
          "borderangle, 0, 7,    md3_decel"
          "fade,        1, 5,  md3_decel"
          "fadeOut,     0, 2,  md3_decel"

          "fadeLayers,  0, 4.5,  md3_decel"
          "workspaces,  1, 1.5,  md3_decel, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        render_ahead_of_time = false;
        disable_hyprland_logo = true;
        focus_on_activate = false;
        no_direct_scanout = true;
        disable_splash_rendering = false;
        background_color = "0x${config.colors.bg}";
        vrr = 2;
      };

      windowrule = [
        "float, ^(floaterm)$"

        "animation popin 90%, ^(feh)$"
        "float, ^(feh)$"
        "size 80% 80%, ^(feh)$"
        "center, ^(feh)$"

        "animation popin 90%, ^(mpv)$"
        "float, ^(mpv)$"
        "size 80% 80%, ^(mpv)$"
        "center, ^(mpv)$"

        "workspace 1, ^(io.github.tdesktop_x64.TDesktop)$"
        "workspace 2, ^(firefox)$"
        "workspace 3, ^(vesktop)$"
        "workspace 4, ^(steam)$"
        "workspace 4, ^(DesktopEditors)"
        # "workspace 5, ^(Chromium-browser)$"

        # "float, ^(Chromium-browser)$"

        "animation slide bottom, ^(wofi)$"
        "move 754 910, ^(wofi)$"
      ];

      windowrulev2 = [
        "center, class:^(steam), title:^(Sign in to Steam)$"
        "tile, class:^(steam), title:^(Special Offers)$"

        "animation popin 80%, class:^(floaterm)$"

        "animation popin 90%, title:^(Медіапереглядач)$"
        "fakefullscreen, title:^(Медіапереглядач)$"
        "float, title:^(Медіапереглядач)$"
        "size 80% 80%,title:^(Медіапереглядач)$"
        "center, title:^(Медіапереглядач)$"

       # "tile, class:^(org.qbittorrent.qBittorrent|Qbittorrent)$"
        "stayfocused, title:^(File Upload|Відкрити torrent-файли)$"
        "forceinput, title:^(File Upload|Відкрити torrent-файли)$"
        #"tile, title:^(File Upload|Открыть торрент-файлы)$"
        #"center, title:^(Выбор файлов|File Upload|Открыть торрент-файлы)$"
        #"size 80% 80%, title:^(Выбор файлов|File Upload|Открыть торрент-файлы)$"
      ];

      exec-once = [
        "rfkill block wifi"
        "env QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop"
        "swaybg --output 'eDP-1' -i ${config.background-image} -m fill"
        "waybar"
      ];

      bind =
      let
        volume     = import ./scripts/volume.nix     { inherit pkgs; };
        gamemode   = import ./scripts/gamemode.nix   { inherit pkgs; };
        touchpad   = import ./scripts/touchpad.nix   { inherit pkgs; };
        microphone = import ./scripts/microphone.nix { inherit pkgs; };
        brightness = import ./scripts/brightness.nix { inherit pkgs; };
      in
      [
        "$mainMod, Return, exec, foot"
        "$mainMod SHIFT, Return, exec, foot -a floaterm -o colors.alpha=1"
        "$mainMod SHIFT, E, exec, foot ranger"
        "$mainMod, Q, killactive,"
        "CONTROLALT, Delete, exit,"
        "CONTROLALT, Backspace, exec, hyprctl reload"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, F, fullscreen,"
        "$mainMod, T, exec, hyprctl --batch 'dispatch togglefloating; dispatch centerwindow 1'"
        "$mainMod, D, exec, wofi --show drun"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, S, togglesplit, # dwindle"

        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"

        "$mainMod SHIFT, left,  swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,    swapwindow, u"
        "$mainMod SHIFT, down,  swapwindow, d"

        "$mainMod CTRL, left, resizeactive, -30 0"
        "$mainMod CTRL, right,  resizeactive,  30 0"
        "$mainMod CTRL, up,  resizeactive,  0 -30"
        "$mainMod CTRL, down,    resizeactive,  0  30"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        ", XF86Display,           exec, ${touchpad}/bin/touchpad"

        ", XF86AudioRaiseVolume,  exec, ${volume}/bin/volume up"
        ", XF86AudioLowerVolume,  exec, ${volume}/bin/volume down"
        ", XF86AudioMute,         exec, ${volume}/bin/volume mute"

        ", F4,                    exec, ${microphone}/bin/microphone"

        ", XF86MonBrightnessUp,   exec, ${brightness}/bin/brightness up"
        ", XF86MonBrightnessDown, exec, ${brightness}/bin/brightness down"

        "$mainMod Shift, G,       exec, ${gamemode}/bin/gamemode"

        ", XF86Sleep, exec, hyprlock"

        ",                Print,   exec, grim -g \"$(slurp)\" - | swappy -f -"
        ",                Pause,   exec, hyprshot -m output -c --clipboard-only -s && notify-send -a hyprshot -t 1000 'screenshot copied'"
        "$mainMod CTRL,   P, exec, notify-send $(hyprpicker -a)"
        "$mainMod,        w, exec, pkill -SIGUSR1 waybar"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
