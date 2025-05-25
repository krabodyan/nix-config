{pkgs, ...}: let
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a swaynotify \
    --urgency low \
    -h string:x-canonical-private-synchronous:swaynotify \
  '';
  bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
in
  pkgs.writeShellScriptBin "__brightness" ''
    if [ "$1" = "up" ]; then
      ${bctl} set 5%+
    elif [ "$1" = "down" ]; then
      ${bctl} set 5%-
    fi

    current_brightness=$(${bctl} get)
    max_brightness=$(${bctl} max)
    b=$((current_brightness * 100 / max_brightness))

    if [ "$1" = "toggle" ]; then
      if [[ $b -eq 0 ]]; then
        ${bctl} set 100%
      else
        ${bctl} set 0
      fi
      exit 0
    fi

    if [[ $b -gt 70 ]]; then
      icon="󰃠 "
    elif [[ $b -gt 40 ]]; then
      icon="󰃟 "
    else
      icon="󰃞 "
    fi

    ${send} "$icon$b" -h "int:value:$b"
  ''
