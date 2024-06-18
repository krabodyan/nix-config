{ pkgs, ... }:
let
  send = "${pkgs.libnotify}/bin/notify-send -t 1500";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
in
  pkgs.writeShellScriptBin "gamemode" ''
    HYPRGAMEMODE=$(${hyprctl} getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$HYPRGAMEMODE" = "1" ] ; then
      ${send} " gamemode enabled "
      ${hyprctl} --batch "\
      keyword animations:enabled 0;\
      keyword decoration:drop_shadow 0;\
      keyword decoration:blur:enabled 0;\
      keyword general:gaps_in 0;\
      keyword general:gaps_out 0;\
      keyword general:border_size 1;\
      keyword decoration:rounding 0"
    else
      ${send} " gamemode disabled 󰅚"
      ${hyprctl} --batch "\
        keyword animations:enabled 1;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 2;\
        keyword general:gaps_out 6;\
        keyword general:border_size 2;\
        keyword decoration:rounding 12"
    fi
  ''
