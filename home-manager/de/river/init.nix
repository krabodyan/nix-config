{theme}:
with theme.colors; let
  kbd = "riverctl keyboard-layout -options grp:alts_toggle,caps:backspace,shift:both_capslock us,ru,ua";
  focused = "0x${surface1}";
  monocle = "0x${bg-dark}";
  border = "0x${bg-dark}";
  timeout = "5000";
in ''
  #!/bin/sh
  riverctl background-color 0x${bg}
  pidof swaybg || swaybg -m fill -i ${theme.background} &
  riverctl border-color-focused ${focused}
  riverctl border-color-urgent ${border}
  riverctl border-color-unfocused ${border}
  # riverctl border-width 4

  riverctl map -layout 0 normal Super       Q      close
  riverctl map -layout 0 normal Super+Shift Delete exit

  riverctl map -layout 0 normal Super E       spawn "foot"
  riverctl map -layout 0 normal Super+Shift E spawn "foot -a floaterm"
  riverctl map -layout 0 normal Super R       spawn "foot -a floaterm pulsemixer"
  riverctl map -layout 0 normal Shift F1      spawn "pidof wl-gammactl && pkill wl-gammactl || wl-gammactl -c 1.3"
  riverctl map -layout 0 normal Shift F2      spawn "pidof wl-gammactl && pkill wl-gammactl || wl-gammactl -g 1.1 -c 1.8"
  riverctl map -layout 0 normal Shift F3      spawn "pidof wl-gammactl && pkill wl-gammactl || wl-gammactl -g 1.3 -c 2"
  riverctl map -layout 0 normal Super D       spawn "pidof rofi && pkill rofi || (${kbd} && rofi -show drun -kb-cancel 'Alt+Return')"

  riverctl map -layout 0 normal Super H focus-view left
  riverctl map -layout 0 normal Super J focus-view down
  riverctl map -layout 0 normal Super K focus-view up
  riverctl map -layout 0 normal Super L focus-view right

  riverctl map -layout 0 normal Super+Shift H swap left
  riverctl map -layout 0 normal Super+Shift J swap down
  riverctl map -layout 0 normal Super+Shift K swap up
  riverctl map -layout 0 normal Super+Shift L swap right

  riverctl map -layout 0 normal Super space  focus-view next
  riverctl map -layout 0 normal Super+Shift  space zoom
  riverctl map -layout 0 normal Alt   tab    focus-view next
  riverctl map -layout 0 normal Super Return spawn "riverctl swap next && riverctl focus-view previous"

  riverctl map -layout 0 normal Super S send-layout-cmd wideriver "--layout monocle"

  riverctl map -layout 0 normal Super O send-layout-cmd wideriver "--ratio +0.02"
  riverctl map -layout 0 normal Super I send-layout-cmd wideriver "--ratio -0.02"

  riverctl map -layout 0 normal Super Right send-layout-cmd wideriver "--count +1"
  riverctl map -layout 0 normal Super Left  send-layout-cmd wideriver "--count -1"

  riverctl map -layout 0 normal Super+Alt K send-layout-cmd wideriver "--layout top"
  riverctl map -layout 0 normal Super+Alt L send-layout-cmd wideriver "--layout right"
  riverctl map -layout 0 normal Super+Alt J send-layout-cmd wideriver "--layout bottom"
  riverctl map -layout 0 normal Super+Alt H send-layout-cmd wideriver "--layout left"

  riverctl map -layout 0 normal Super tab focus-previous-tags

  riverctl map -layout 0 normal Super     b hide-cursor timeout ${timeout}
  riverctl map -layout 0 normal Super+Alt b hide-cursor timeout 0
  riverctl hide-cursor timeout ${timeout}

  riverctl set-repeat 40 330
  ${kbd}
  riverctl map -layout 0 normal Super W spawn "${kbd}"

  riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events disabled
  riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" scroll-factor 0.2
  riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" pointer-accel 0.3
  riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" accel-profile flat
  riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" accel-profile flat
  riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" pointer-accel 0

  riverctl map-pointer normal Super+Shift BTN_LEFT move-view
  riverctl map-pointer normal Super+Shift BTN_RIGHT resize-view

  for i in $(seq 1 7)
  do
    tags=$((1 << ($i - 1)))
    riverctl map -layout 0 normal Super $i set-focused-tags $tags
    riverctl map -layout 0 normal Super+Shift $i set-view-tags $tags
    riverctl map -layout 0 normal Super+Control $i toggle-focused-tags $tags
    riverctl map -layout 0 normal Super+Shift+Control $i toggle-view-tags $tags
  done

  riverctl map -layout 0 normal Super F toggle-float
  riverctl map -layout 0 normal Super T toggle-fullscreen

  riverctl map -layout 0 normal Super F10                   spawn '__touchpad'
  riverctl map -layout 0 normal None  XF86AudioRaiseVolume  spawn '__volume up'
  riverctl map -layout 0 normal None  XF86AudioLowerVolume  spawn '__volume down'
  riverctl map -layout 0 normal None  XF86AudioMute         spawn '__volume mute'
  riverctl map -layout 0 normal None  F4                    spawn '__microphone'
  riverctl map -layout 0 normal None  XF86MonBrightnessUp   spawn '__brightness up'
  riverctl map -layout 0 normal None  XF86MonBrightnessDown spawn '__brightness down'
  riverctl map -layout 0 normal Super X                     spawn '__brightness toggle'
  riverctl map -layout 0 normal Super V                     spawn 'notify-send --expire-time 2000 "$(date +"%d %B %H:%M") |$(acpi | cut -d , -f 2)"'
  riverctl map -layout 0 normal None        Print spawn "__screenshot"
  riverctl map -layout 0 normal None        Pause spawn "__screenshot full";
  riverctl map -layout 0 normal Super       Print spawn "__screenshot swayimg";
  riverctl map -layout 0 normal Super+Shift Print spawn "wl-paste | satty -f -";
  riverctl map -layout 0 normal Super+Shift 0     spawn "swaylock"


  array=("Виберіть файли" "Відкрити файли" "Зберегти відео" "Вивантаження файлу" "File Upload" "Відкрити документ" "Зберегти файл" "Open File" "Зберегти зображення")
  for item in "$\{array[@]}"; do
    riverctl rule-add -title "$item" float
    riverctl rule-add -title "$item" dimensions 1000 800
  done

  riverctl rule-add -app-id "*" ssd
  riverctl rule-add -app-id "org.telegram.desktop" tags 1
  riverctl rule-add -app-id "google-chrome" tags 2
  riverctl rule-add -app-id "firefox" tags 2
  riverctl rule-add -app-id "vesktop" tags 4
  riverctl rule-add -app-id "steam" tags 16
  riverctl rule-add -app-id "steam" no-float
  riverctl rule-add -app-id "zoom" tags 8
  riverctl rule-add -app-id "zoom" float
  riverctl rule-add -app-id "ONLYOFFICE" tags 16

  riverctl rule-add -app-id 'floaterm' float

  riverctl rule-add -app-id "xdg-desktop-portal-gtk" float
  riverctl rule-add -app-id "xdg-desktop-portal-gtk" dimensions 1000 800

  riverctl rule-add -title "Медіапереглядач" no-fullscreen
  riverctl rule-add -title "Медіапереглядач" float

  riverctl default-layout wideriver

  pidof wideriver || wideriver \
    --layout                       left        \
    --layout-alt                   monocle     \
    --stack                        even        \
    --smart-gaps                               \
    --count-master                 1           \
    --ratio-master                 0.50        \
    --count-wide-left              0           \
    --ratio-wide                   0.35        \
    --inner-gaps                   0           \
    --outer-gaps                   0           \
    --border-color-focused         ${focused}  \
    --border-color-focused-monocle ${monocle}  \
    --border-color-unfocused       ${border}   \
    --border-width                 2           \
    --border-width-monocle         0           \
    --border-width-smart-gaps      0           \
    --log-threshold                error       \
    > /dev/null &

  pidof dbus-daemon || {
    dbus-daemon --session --address=unix:path=/run/user/1000/bus --fork
    # systemctl --user set-environment XDG_CURRENT_DESKTOP=river
    # systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS
    # dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS
    # systemctl --user start river-session.target
    # firefox &
    # QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop &
    # vesktop &
  }
  systemctl --user is-active wireplumber.service || systemctl --user restart wireplumber.service
''
