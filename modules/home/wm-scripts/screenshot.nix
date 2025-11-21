{
  pkgs,
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
    grim = "${pkgs.grim}/bin/grim -t png";
    swayimg = "swayimg --config info.show=no";
    slurp = "slurp -w 2 -b ${colors.bg}b3 -c ${colors.select}ff -B ${colors.bg}b3";
  in
    # bash
    ''
      mode="''${1:-}"
      pidof slurp && exit 0
      makoctl dismiss

      if [ "$mode" = "full" ]; then
        ${grim} - | ${copy}
        exit 0
      fi

      if [ "$mode" = "swayimg" ]; then
        ${grim} - | ${swayimg} - &
        PID=$!
      fi

      size=$(${slurp})
      status=$?

      if [ $status -eq 0 ]; then
        ${grim} -g "$size" - | ${copy}
      fi

      if [ "$mode" = "swayimg" ]; then
        kill "$PID"
      fi
    '';
}
