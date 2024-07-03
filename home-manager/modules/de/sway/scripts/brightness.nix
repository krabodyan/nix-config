{ pkgs, ... }:
let
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -a hypr-notify \
    -t 1500 \
    -h string:x-canonical-private-synchronous:hyprnotify \
  '';
  bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
in
pkgs.writeShellScriptBin "brightness" ''
  if [ "$1" = "up" ]; then
    ${bctl} set 5%+
  elif [ "$1" = "down" ]; then
    ${bctl} set 5%-
  fi
  current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
  max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
  b=$((current_brightness * 100 / max_brightness))
  if [[ $b -gt 70 ]]; then
    icon="󰃠 "
  elif [[ $b -gt 40 ]]; then
    icon="󰃟 "
  else
    icon="󰃞 "
  fi
  ${send} "$icon$b" -h "int:value:$b"
''
