{
  pkgs,
  type,
  device ? null,
  ...
}: let
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a swaynotify \
    --urgency low \
    -h string:x-canonical-private-synchronous:swaynotify \
  '';
in
  if type == "sway"
  then
    pkgs.writeShellScriptBin "__touchpad" ''
      swaymsg input type:touchpad events toggle enabled disabled
      ${send} "touchpad toggled"
    ''
  else
    assert device != null || throw "cant use river touchpad settings without device";
      pkgs.writeShellScriptBin "__touchpad"
      ''
        if riverctl list-input-configs | grep -q "disabled"; then
          riverctl input "${device}" events enabled
          ${send} "touchpad enabled"
        else
          riverctl input "${device}" events disabled
          ${send} "touchpad disabled"
        fi
      ''
