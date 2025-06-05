{
  pkgs,
  send,
  ...
}:
pkgs.writeShellApplication {
  name = "__microphone";

  runtimeInputs = with pkgs; [
    gnugrep
    pamixer
  ];

  text = ''
    pamixer --default-source -t
    if pamixer --default-source --get-mute | grep -q "true"; then
      ${send} "󰍭 $(pamixer --default-source --get-volume-human)"
    else
      h="int:value:$(pamixer --default-source --get-volume)"
      ${send} " $(pamixer --default-source --get-volume-human)" -h "$h"
    fi
  '';
}
