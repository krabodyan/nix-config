{pkgs, ...}: let
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a swaynotify \
    -h string:x-canonical-private-synchronous:swaynotify \
  '';
in
  pkgs.writeShellScriptBin "__volume" ''
    if [ "$1" = "mute" ]; then
      ${pamixer} -t
    fi

    if ${pamixer} --get-mute | grep -q "true"; then
      ${send} "󰖁 $(${pamixer} --get-volume-human)"
      exit
    fi

    if [ "$1" = "up" ]; then
      ${pamixer} -i 5
    elif [ "$1" = "down" ]; then
      ${pamixer} -d 5
    fi

    ${send} -h "int:value:$(${pamixer} --get-volume)" "󰕾 $(${pamixer} --get-volume-human)"
  ''
