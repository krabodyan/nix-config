{ pkgs, ... }:
let
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a swaynotify \
    -h string:x-canonical-private-synchronous:swaynotify \
  '';
  toggle = ''
    riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events \
  '';
in pkgs.writeShellScriptBin "__touchpad" ''
  if riverctl list-input-configs | grep -q "disabled"; then
    ${toggle} enabled
    ${send} "touchpad enabled"
  else
    ${toggle} disabled
    ${send} "touchpad disabled"
  fi
''
