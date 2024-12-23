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

      riverctl map -layout 0 normal Super Q close
      riverctl map -layout 0 normal Super+Shift Delete exit

      riverctl map -layout 0 normal Super E spawn foot
      riverctl map -layout 0 normal Super+Shift E spawn "foot -a floaterm"

      riverctl map -layout 0 normal Super D spawn "pidof rofi && pkill rofi || rofi -show drun -kb-cancel 'Alt+Return'"

      riverctl map -layout 0 normal Super J focus-view next
      riverctl map -layout 0 normal Alt tab focus-view next
      riverctl map -layout 0 normal Super K focus-view previous
      riverctl map -layout 0 normal Super space zoom
      riverctl map -layout 0 normal Super tab focus-previous-tags

      # riverctl map -layout 0 normal Super+Shift J swap next
      # riverctl map -layout 0 normal Super+Shift K swap previous

      # riverctl map -layout 0 normal Super+Alt H move left 100
      # riverctl map -layout 0 normal Super+Alt J move down 100
      # riverctl map -layout 0 normal Super+Alt K move up 100
      # riverctl map -layout 0 normal Super+Alt L move right 100

      # riverctl map -layout 0 normal Super+Alt+Control H snap left
      # riverctl map -layout 0 normal Super+Alt+Control J snap down
      # riverctl map -layout 0 normal Super+Alt+Control K snap up
      # riverctl map -layout 0 normal Super+Alt+Control L snap right

      # riverctl map -layout 0 normal Super+Alt+Shift H resize horizontal -100
      # riverctl map -layout 0 normal Super+Alt+Shift J resize vertical 100
      # riverctl map -layout 0 normal Super+Alt+Shift K resize vertical -100
      # riverctl map -layout 0 normal Super+Alt+Shift L resize horizontal 100

      riverctl hide-cursor timeout 7000
      riverctl set-repeat 40 330
      riverctl keyboard-layout -options grp:alt_caps_toggle us,ua,ru
      riverctl map -layout 0 normal Super W keyboard-layout -options grp:alt_caps_toggle us,ua,ru

      riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events disabled-on-external-mouse
      riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" accel-profile flat
      riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" pointer-accel 0

      riverctl map -layout 0 -pointer normal Super BTN_LEFT move-view
      riverctl map -layout 0 -pointer normal Super BTN_RIGHT resize-view

      for i in $(seq 1 9)
      do
          tags=$((1 << ($i - 1)))
          riverctl map -layout 0 normal Super $i set-focused-tags $tags
          riverctl map -layout 0 normal Super+Shift $i set-view-tags $tags
          riverctl map -layout 0 normal Super+Control $i toggle-focused-tags $tags
          riverctl map -layout 0 normal Super+Shift+Control $i toggle-view-tags $tags
      done

      # all_tags=$(((1 << 32) - 1))
      # riverctl map -layout 0 normal Super 0 set-focused-tags $all_tags
      # riverctl map -layout 0 normal Super+Shift 0 set-view-tags $all_tags

      riverctl map -layout 0 normal Super F toggle-float
      riverctl map -layout 0 normal Super T toggle-fullscreen

      riverctl map -layout 0 normal None  XF86AudioRaiseVolume  spawn '__volume up'
      riverctl map -layout 0 normal None  XF86AudioLowerVolume  spawn '__volume down'
      riverctl map -layout 0 normal None  XF86AudioMute         spawn '__volume mute'
      riverctl map -layout 0 normal None  F4                    spawn '__microphone'
      riverctl map -layout 0 normal None  XF86MonBrightnessUp   spawn '__brightness up'
      riverctl map -layout 0 normal None  XF86MonBrightnessDown spawn '__brightness down'
      riverctl map -layout 0 normal Super X                     spawn '__brightness toggle'

      riverctl map -layout 0 normal None        Print spawn "__screenshot"
      riverctl map -layout 0 normal None        Pause spawn "__screenshot full";
      riverctl map -layout 0 normal Super       Print spawn "__screenshot swayimg";
      riverctl map -layout 0 normal Super+Shift Print spawn "wl-paste | satty -f -";

      riverctl rule-add -app-id "com.ayugram" tags 1
      riverctl rule-add -app-id "google-chrome" tags 2
      riverctl rule-add -app-id "vesktop" tags 4
      riverctl rule-add -app-id "steam" tags 8
      riverctl rule-add -app-id "steam" csd
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

      riverctl map -layout 0 normal Super S send-layout-cmd wideriver "--layout monocle"

      riverctl map -layout 0 normal Super H send-layout-cmd wideriver "--ratio -0.03"
      riverctl map -layout 0 normal Super L send-layout-cmd wideriver "--ratio +0.03"

      riverctl map -layout 0 normal Super Right send-layout-cmd wideriver "--count +1"
      riverctl map -layout 0 normal Super Left send-layout-cmd wideriver "--count -1"

      riverctl map -layout 0 normal Super+Shift K send-layout-cmd wideriver "--layout top"
      riverctl map -layout 0 normal Super+Shift L send-layout-cmd wideriver "--layout right"
      riverctl map -layout 0 normal Super+Shift J send-layout-cmd wideriver "--layout bottom"
      riverctl map -layout 0 normal Super+Shift H send-layout-cmd wideriver "--layout left"
    '';
  };
}
