{
  pkgs,
  send,
  colors,
  ...
}:
pkgs.writeShellApplication {
  name = "__screenshot";

  runtimeInputs = with pkgs; [
    jq
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
      mode="''${1:-}"
      pidof slurp && exit 0
      makoctl dismiss

      if [ "$mode" = "full" ]; then
        ${wayshot} | ${copy}
        ${send} "screenshot copied"
        exit 0
      fi

      if [ "$mode" = "window" ]; then
        size=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | ${slurp})
        status=$?

        if [ $status -eq 0 ]; then
          ${wayshot} -s "$size" | ${copy}
          ${send} "screenshot copied"
        fi

        exit 0
      fi

      if [ "$mode" = "swayimg" ]; then
        ${wayshot} | ${swayimg} - &
        PID=$!
      fi

      size=$(${slurp})
      status=$?

      if [ $status -eq 0 ]; then
        ${wayshot} -s "$size" | ${copy}
        ${send} "screenshot copied"
      fi

      if [ "$mode" = "swayimg" ]; then
        kill "$PID"
      fi
    '';
}
