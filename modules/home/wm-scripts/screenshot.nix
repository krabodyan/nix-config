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
    "screenshot copied"
  '';
  copy = "${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
  swayimg = "${pkgs.swayimg}/bin/swayimg --config info.show=no";
  wayshot = "${pkgs.wayshot}/bin/wayshot --extension png --stdout";
  slurp = with colors; "${pkgs.slurp}/bin/slurp -w 2 -b ${bg}b3 -c ${select}ff -B ${bg}b3";
in
  pkgs.writeShellScriptBin "__screenshot" ''
    pidof slurp && exit 0
    ${pkgs.mako}/bin/makoctl dismiss

    if [ "$1" = "full" ]; then
      ${wayshot} | ${copy}
      ${send}
      exit 0
    fi

    if [ "$1" = "window" ]; then
      size=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | ${slurp})
      status=$?

      if [ $status -eq 0 ]; then
        ${wayshot} -s "$size" | ${copy}
        ${send}
      fi

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
      ${send}
    fi

    if [ "$1" = "swayimg" ]; then
      kill $PID
    fi
  ''
