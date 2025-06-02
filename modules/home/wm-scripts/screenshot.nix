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
  wayshot = "${pkgs.wayshot}/bin/wayshot --extension png --stdout";
  copy = "${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
  slurp = "${pkgs.slurp}/bin/slurp -b ${colors.bg}66 -c ${colors.select}";
  swayimg = "${pkgs.swayimg}/bin/swayimg --config info.show=no";
in
  pkgs.writeShellScriptBin "__screenshot" ''
    pidof slurp && exit 0
    ${pkgs.mako}/bin/makoctl dismiss

    if [ "$1" = "full" ]; then
      ${wayshot} | ${copy}
      ${send} "screenshot copied"
      exit 0
    fi

    if [ "$1" = "swayimg" ]; then
      ${wayshot} | ${swayimg} - &
      PID=$!
    fi

    size=$(${slurp})
    status=$?

    if [ $status -eq 0 ]; then
      ${wayshot} -s "$size" | ${copy}
      ${send} "screenshot copied"
    fi

    if [ "$1" = "swayimg" ]; then
      kill $PID
    fi
  ''
