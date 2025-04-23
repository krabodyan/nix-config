{
  pkgs,
  touchpad-cmd,
  ...
}: let
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a swaynotify \
    -h string:x-canonical-private-synchronous:swaynotify \
    --urgency low \
  '';
in
  pkgs.writeShellScriptBin "__touchpad" ''
    ${touchpad-cmd}
    ${send} "touchpad toggled"
  ''
