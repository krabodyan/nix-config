{
  pkgs,
  send,
  touchpadDevice,
  ...
}:
pkgs.writeShellApplication {
  name = "__touchpad";

  runtimeInputs = with pkgs; [
    river
    gnugrep
  ];

  text =
    # bash
    ''
      if riverctl list-input-configs | grep -q "disabled"; then
        riverctl input "${touchpadDevice}" events enabled
        ${send} "touchpad enabled"
      else
        riverctl input "${touchpadDevice}" events disabled
        ${send} "touchpad disabled"
      fi
    '';
}
