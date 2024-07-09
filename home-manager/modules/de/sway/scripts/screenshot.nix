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
  ${grim} -t png -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy
  pkill swayimg
  ${send} "screenshot copied"
''
