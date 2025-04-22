{
  pkgs,
  touchpad-cmd,
  ...
}: let
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    --urgency low \
  '';
in
  pkgs.writeShellScriptBin "__touchpad" ''
    makoctl dismiss
    ${touchpad-cmd}
    ${send} "touchpad toggled"
  ''
