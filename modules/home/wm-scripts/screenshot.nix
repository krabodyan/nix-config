{
  pkgs,
  colors,
  ...
}: let
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a swaynotify \
    --urgency low \
    -h string:x-canonical-private-synchronous:swaynotify \
  '';
  grim = "${pkgs.grim}/bin/grim -t png";
  slurp = "${pkgs.slurp}/bin/slurp -b ${colors.bg}66 -c ${colors.select}";
  swayimg = "${pkgs.swayimg}/bin/swayimg --config info.show=no";
  copy = "${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
  mako = "${pkgs.mako}/bin/makoctl";
in
  pkgs.writeShellScriptBin "__screenshot" ''
    pidof slurp && exit 0
    ${mako} dismiss

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
    fi

    if [ "$1" = "swayimg" ]; then
      kill $PID
    fi
  ''
