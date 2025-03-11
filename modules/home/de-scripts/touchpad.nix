{
  pkgs,
  toggleup,
  toggledown,
  ...
}: let
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
  '';
in
  pkgs.writeShellScriptBin "__touchpad" ''
    if riverctl list-input-configs | grep -q "disabled"; then
      ${toggleup}
      ${send} "touchpad enabled"
    else
      ${toggledown}
      ${send} "touchpad disabled"
    fi
  ''
