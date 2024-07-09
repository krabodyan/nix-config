{ pkgs, ... }:
let
  grim = "${pkgs.grim}/bin/grim";
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a hypr-notify \
    -h string:x-canonical-private-synchronous:hyprnotify \
  '';
in
pkgs.writeShellScriptBin "screenshot" ''
  ${grim} -t png - | ${pkgs.swayimg}/bin/swayimg - &
  size=$(${pkgs.slurp}/bin/slurp)
  status=$?
  if [ $status -eq 0 ]; then
    ${grim} -t png -g "$size" - | ${pkgs.wl-clipboard}/bin/wl-copy
    ${send} "screenshot copied"
  else
    ${send} "screenshot canceled"
  fi
  pkill swayimg
''
