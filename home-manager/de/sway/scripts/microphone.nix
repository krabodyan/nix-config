{ pkgs, ... }:
let
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  send = ''
    ${pkgs.libnotify}/bin/notify-send \
    -t 1000 \
    -a swaynotify \
    -h string:x-canonical-private-synchronous:swaynotify \
  '';
in
pkgs.writeShellScriptBin "microphone" ''
  ${pamixer} --default-source -t
  pw-cat -p ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga &
  if ${pamixer} --default-source --get-mute | grep -q "true"; then
    ${send} "󰍭 $(${pamixer} --default-source --get-volume-human)"
  else
    h="int:value:$(${pamixer} --default-source --get-volume)"
    ${send} " $(${pamixer} --default-source --get-volume-human)" -h $h
  fi
''
