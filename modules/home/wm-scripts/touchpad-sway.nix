{
  pkgs,
  send,
  ...
}:
pkgs.writeShellApplication {
  name = "__touchpad";

  runtimeInputs = with pkgs; [
    sway
  ];

  text =
    # bash
    ''
      swaymsg input type:touchpad events toggle enabled disabled
      status=$(swaymsg -t get_inputs --raw | jq -r '.[] | select(.type == "touchpad").libinput.send_events')
      if [ "$status" = "enabled" ]; then
        ${send} "󰭯  touchpad enabled"
      else
        ${send} "󱘂  touchpad disabled"
      fi
    '';
}
