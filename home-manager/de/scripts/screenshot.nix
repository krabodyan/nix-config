{ pkgs, theme, ... }:
let
  grim = "${pkgs.grim}/bin/grim -t png";
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a swaynotify \
    -h string:x-canonical-private-synchronous:swaynotify \
  '';
  slurp =
    "${pkgs.slurp}/bin/slurp -b ${theme.colors.bg}d9 -c ${theme.colors.select}";
  copy = "${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
  swayimg = "${pkgs.swayimg}/bin/swayimg --config info.show=no";

in pkgs.writeShellScriptBin "__screenshot" ''
  makoctl dismiss
  if [ "$1" = "full" ]; then
    ${grim} - | ${copy}
    ${send} "screenshot copied"
    exit 0
  fi
  if [ "$1" = "swayimg" ]; then
    ${grim} - | ${swayimg} - &
    PID=$!
  fi
  size=$(${slurp})
  status=$?
  if [ $status -eq 0 ]; then
    ${grim} -g "$size" - | ${copy}
    ${send} "screenshot copied"
  else
    ${send} "screenshot canceled"
  fi

  if [ "$1" = "swayimg" ]; then
    kill $PID
  fi
''
