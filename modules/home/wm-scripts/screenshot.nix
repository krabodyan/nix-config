{
  pkgs,
  send,
  colors,
  ...
}:
pkgs.writeShellApplication {
  name = "__screenshot";

  runtimeInputs = with pkgs; [
    mako
    slurp
    swayimg
    wayshot
    wl-clipboard
  ];

  text = let
    copy = "wl-copy -t image/png";
    slurp = "slurp -w 2 -b ${colors.bg}b3 -c ${colors.select}ff -B ${colors.bg}b3";
    swayimg = "swayimg --config info.show=no";
    wayshot = "wayshot --extension png --stdout";
  in
    # bash
    ''
      pidof slurp && exit 0
      makoctl dismiss

      if [ "$1" = "full" ]; then
        ${wayshot} | ${copy}
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
        kill "$PID"
      fi
    '';
}
