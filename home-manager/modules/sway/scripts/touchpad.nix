{ pkgs, ... }:
let
  config = "/home/krabodyan/nix-config/home-manager/modules/misc/touchpad.conf";
  send = "${pkgs.libnotify}/bin/notify-send -u low -t 1000 -a hypr-notify -h string:x-canonical-private-synchronous:hyprnotify";
in
  pkgs.writeShellScriptBin "touchpad" ''
    enabled=$(grep -o "enabled\s*=\s*[01]" "${config}")
    if [ "$enabled" == "enabled = 0" ]; then
      sed -i "s/enabled\s*=\s*0/enabled = 1/" "${config}"
      ${send} "touchpad enabled "
    else
      sed -i "s/enabled\s*=\s*1/enabled = 0/" "${config}"
      ${send} "touchpad disabled 󰅚"
    fi
  ''
