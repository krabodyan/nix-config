{ pkgs, ... }: {
  home.packages = with pkgs; [ swaybg wideriver ];
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    extraSessionVariables = { XDG_CURRENT_DESKTOP = "river"; };
    extraConfig = ''
      riverctl background-color 0x0f0f0f
      # riverctl border-color-focused 0x303030
      # riverctl border-color-unfocused 0x151515
      # riverctl border-width 4

      # swaybg -m fill -i ~/flake/assets/background.jpg &

      riverctl map normal Super Q close
      riverctl map normal Super+Shift Delete exit

      riverctl map normal Super E spawn foot
      riverctl map normal Super+Shift E spawn "foot -a floaterm"
      riverctl map normal Super D spawn "pidof rofi && pkill rofi || rofi -show drun -kb-cancel 'Alt+Return'"

      riverctl map normal Super J focus-view next
      riverctl map normal Alt tab focus-view next
      riverctl map normal Super K focus-view previous
      riverctl map normal Super space zoom
      riverctl map normal Super tab focus-previous-tags

      # riverctl map normal Super+Shift J swap next
      # riverctl map normal Super+Shift K swap previous


      # Super+Alt+{H,J,K,L} to move views
      # riverctl map normal Super+Alt H move left 100
      # riverctl map normal Super+Alt J move down 100
      # riverctl map normal Super+Alt K move up 100
      # riverctl map normal Super+Alt L move right 100

      # Super+Alt+Control+{H,J,K,L} to snap views to screen edges
      # riverctl map normal Super+Alt+Control H snap left
      # riverctl map normal Super+Alt+Control J snap down
      # riverctl map normal Super+Alt+Control K snap up
      # riverctl map normal Super+Alt+Control L snap right

      # Super+Alt+Shift+{H,J,K,L} to resize views
      riverctl map normal Super+Alt+Shift H resize horizontal -100
      riverctl map normal Super+Alt+Shift J resize vertical 100
      riverctl map normal Super+Alt+Shift K resize vertical -100
      riverctl map normal Super+Alt+Shift L resize horizontal 100

      riverctl hide-cursor timeout 7000
      riverctl set-repeat 40 330
      riverctl keyboard-layout -options grp:alt_caps_toggle us,ua,ru
      riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events disabled-on-external-mouse
      riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" accel-profile flat
      riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" pointer-accel 0

      riverctl map-pointer normal Super BTN_LEFT move-view
      riverctl map-pointer normal Super BTN_RIGHT resize-view

      for i in $(seq 1 9)
      do
          tags=$((1 << ($i - 1)))
          # Super+[1-9] to focus tag [0-8]
          riverctl map normal Super $i set-focused-tags $tags
          # Super+Shift+[1-9] to tag focused view with tag [0-8]
          riverctl map normal Super+Shift $i set-view-tags $tags
          # Super+Control+[1-9] to toggle focus of tag [0-8]
          riverctl map normal Super+Control $i toggle-focused-tags $tags
          # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
          riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
      done

      # Super+0 to focus all tags
      # Super+Shift+0 to tag focused view with all tags
      # all_tags=$(((1 << 32) - 1))
      # riverctl map normal Super 0 set-focused-tags $all_tags
      # riverctl map normal Super+Shift 0 set-view-tags $all_tags

      riverctl map normal Super F toggle-float
      riverctl map normal Super T toggle-fullscreen

      riverctl map normal None  XF86AudioRaiseVolume  spawn '__volume up'
      riverctl map normal None  XF86AudioLowerVolume  spawn '__volume down'
      riverctl map normal None  XF86AudioMute         spawn '__volume mute'
      riverctl map normal None  F4                    spawn '__microphone'
      riverctl map normal None  XF86MonBrightnessUp   spawn '__brightness up'
      riverctl map normal None  XF86MonBrightnessDown spawn '__brightness down'
      riverctl map normal Super X                     spawn '__brightness toggle'

      riverctl map normal None        Print spawn "__screenshot"
      riverctl map normal None        Pause spawn "__screenshot full";
      riverctl map normal Super       Print spawn "__screenshot swayimg";
      riverctl map normal Super+Shift Print spawn "wl-paste | satty -f -";

      riverctl rule-add -app-id "com.ayugram" tags 1
      riverctl rule-add -app-id "google-chrome" tags 2
      riverctl rule-add -app-id "vesktop" tags 4
      riverctl rule-add -app-id "steam" tags 8
      riverctl rule-add -app-id "steam" ssd
      riverctl rule-add -app-id "steam" no-float
      riverctl rule-add -app-id "zoom" tags 8
      riverctl rule-add -app-id 'floaterm' float

      riverctl default-layout wideriver

      wideriver \
          --layout                       left        \
          --layout-alt                   monocle     \
          --stack                        dwindle     \
          --no-smart-gaps                            \
          --count-master                 1           \
          --ratio-master                 0.50        \
          --count-wide-left              0           \
          --ratio-wide                   0.35        \
          --border-color-focused         0x303030    \
          --border-color-focused-monocle 0x303030    \
          --border-color-unfocused       0x151515    \
          --inner-gaps                   3           \
          --outer-gaps                   0           \
          --border-width                 3           \
          --border-width-monocle         3           \
          --border-width-smart-gaps      0           \
          --log-threshold                error       \
         > "/tmp/wideriver.$\{XDG_VTNR}.$\{USER}.log" 2>&1 &

      riverctl map normal Super S send-layout-cmd wideriver "--layout monocle"

      riverctl map normal Super H send-layout-cmd wideriver "--ratio -0.03"
      riverctl map normal Super L send-layout-cmd wideriver "--ratio +0.03"

      riverctl map normal Super Right send-layout-cmd wideriver "--count +1"
      riverctl map normal Super Left send-layout-cmd wideriver "--count -1"

      riverctl map normal Super+Shift K send-layout-cmd wideriver "--layout top"
      riverctl map normal Super+Shift L send-layout-cmd wideriver "--layout right"
      riverctl map normal Super+Shift J send-layout-cmd wideriver "--layout bottom"
      riverctl map normal Super+Shift H send-layout-cmd wideriver "--layout left"
    '';
  };
}
