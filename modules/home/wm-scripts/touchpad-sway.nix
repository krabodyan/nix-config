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
      ${send} "touchpad toggled"
    '';
}
