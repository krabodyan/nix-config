{ pkgs, colors, ... }:
let
  grim = "${pkgs.grim}/bin/grim -t png";
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a hypr-notify \
    -h string:x-canonical-private-synchronous:hyprnotify \
  '';
  slurp = "${pkgs.slurp}/bin/slurp -b ${colors.bg}d9 -c ${colors.accent}";
  copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  swayimg = "${pkgs.swayimg}/bin/swayimg --config info.mode=off";
in

pkgs.writeShellScriptBin "screenshot" ''
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
