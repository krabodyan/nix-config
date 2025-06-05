{
  pkgs,
  send,
  ...
}:
pkgs.writeShellApplication {
  name = "__brightness";

  runtimeInputs = with pkgs; [
    brightnessctl
  ];

  text = ''
    if [ "$1" = "up" ]; then
      brightnessctl set 5%+
    elif [ "$1" = "down" ]; then
      brightnessctl set 5%-
    fi

    current_brightness=$(brightnessctl get)
    max_brightness=$(brightnessctl max)
    b=$((current_brightness * 100 / max_brightness))

    if [ "$1" = "toggle" ]; then
      if [[ $b -eq 0 ]]; then
        brightnessctl set 100%
      else
        brightnessctl set 0
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
  '';
}
