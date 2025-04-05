{
  lib,
  colors,
  config,
  background,
  extraConfig,
}:
with colors; let
  term = "foot";
  focused = "0x${surface1}";
  border = "0x${bg-dark}";
  kbd = "riverctl keyboard-layout -options grp:alts_toggle,caps:backspace,shift:both_capslock us,ua,ru";

  picker-rules =
    builtins.concatStringsSep "\n"
    (builtins.map
      (
        title: ''
          riverctl rule-add -title "${title}" float
          riverctl rule-add -title "${title}" dimensions 1000 800
        ''
      )
      [
        "File Upload"
        "Open File"
        "Open Document"
        "Choose Files"
      ]);
in
  ''
    #!/bin/bash
    riverctl background-color 0x${bg}
    pidof swaybg || swaybg -m fill -i ${background} &
    riverctl border-color-focused ${focused}
    riverctl border-color-urgent ${border}
    riverctl border-color-unfocused ${border}
    riverctl border-width 2

    riverctl map -layout 0 normal Super       Q      close
    riverctl map -layout 0 normal Super+Shift Delete exit

    riverctl map -layout 0 normal Super E       spawn "${term}"
    riverctl map -layout 0 normal Super+Shift E spawn "${term} -a floaterm"
    riverctl map -layout 0 normal Super R       spawn "${term} -a floaterm pulsemixer"

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
    riverctl map -layout 0 normal Super Return spawn "riverctl swap next && riverctl focus-view previous"

    riverctl map -layout 0 normal Super S send-layout-cmd rivercarro "main-location-cycle monocle,left"

    riverctl map -layout 0 normal Super O send-layout-cmd rivercarro "main-ratio +0.02"
    riverctl map -layout 0 normal Super I send-layout-cmd rivercarro "main-ratio -0.02"

    riverctl map -layout 0 normal Super Right send-layout-cmd rivercarro "main-count +1"
    riverctl map -layout 0 normal Super Left  send-layout-cmd rivercarro "main-count -1"

    riverctl map -layout 0 normal Super+Alt K send-layout-cmd rivercarro "main-location top"
    riverctl map -layout 0 normal Super+Alt L send-layout-cmd rivercarro "main-location right"
    riverctl map -layout 0 normal Super+Alt J send-layout-cmd rivercarro "main-location bottom"
    riverctl map -layout 0 normal Super+Alt H send-layout-cmd rivercarro "main-location left"

    riverctl map -layout 0 normal Super tab focus-previous-tags

    riverctl hide-cursor timeout 5000
    riverctl map -layout 0 normal Super     b hide-cursor timeout 5000
    riverctl map -layout 0 normal Super+Alt b hide-cursor timeout 0

    riverctl xcursor-theme ${config.home.pointerCursor.name} ${builtins.toString config.home.pointerCursor.size}
    riverctl set-repeat 40 400
    ${kbd}
    riverctl map -layout 0 normal Super W spawn "${kbd}"

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
    riverctl map -layout 0 normal Super C                     spawn 'notify-send --expire-time 2000 "$(date +"%d %B %H:%M")"'
    riverctl map -layout 0 normal None        Print spawn "__screenshot"
    riverctl map -layout 0 normal None        Pause spawn "__screenshot full";
    riverctl map -layout 0 normal Super       Print spawn "__screenshot swayimg";
    riverctl map -layout 0 normal Super+Shift Print spawn "wl-paste | swappy -f -";
    riverctl map -layout 0 normal Super+Shift 0     spawn "swaylock"

    riverctl rule-add -app-id "*" ssd
    riverctl rule-add -app-id "org.telegram.desktop" tags 1
    riverctl rule-add -app-id "google-chrome" tags 2
    riverctl rule-add -app-id "firefox" tags 2
    riverctl rule-add -app-id "vesktop" tags 4
    riverctl rule-add -app-id "steam" tags 16
    riverctl rule-add -app-id "steam" no-float
    riverctl rule-add -app-id "zoom" tags 8
    riverctl rule-add -app-id "zoom" -title "zoom" float
    riverctl rule-add -app-id "ONLYOFFICE" tags 16

    riverctl rule-add -app-id "floaterm" float

    riverctl rule-add -app-id "xdg-desktop-portal-gtk" float
    riverctl rule-add -app-id "xdg-desktop-portal-gtk" dimensions 1000 800
    riverctl rule-add -title "Медіапереглядач" no-fullscreen
    riverctl rule-add -title "Медіапереглядач" float
    ${picker-rules}

    riverctl default-layout rivercarro

    pidof rivercarro || rivercarro -inner-gaps 0 -outer-gaps 0 -per-tag -main-ratio 0.5 &
    pidof dbus-daemon || dbus-daemon --session --address=unix:path=/run/user/1000/bus --fork &
  ''
  + (lib.optionalString (config.module.clipse.enable) ''
    riverctl map -layout 0 normal Super V spawn "pidof clipse && pkill clipse || ${term} -w 850x800 -a floaterm clipse"
    clipse -listen &
  '')
  + (lib.optionalString (extraConfig != null) extraConfig)
