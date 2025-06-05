{
  pkgs,
  send,
  ...
}:
pkgs.writeShellApplication {
  name = "__volume";

  runtimeInputs = with pkgs; [
    gnugrep
    pamixer
  ];

  text = ''
    if [ "$1" = "mute" ]; then
      pamixer -t
    fi

    if pamixer --get-mute | grep -q "true"; then
      ${send} "󰖁 $(pamixer --get-volume-human)"
      exit 0
    fi

    if [ "$1" = "up" ]; then
      pamixer -i 5
    elif [ "$1" = "down" ]; then
      pamixer -d 5
    fi

    ${send} -h "int:value:$(pamixer --get-volume)" "󰕾 $(pamixer --get-volume-human)"
  '';
}
