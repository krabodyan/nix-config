{ pkgs, ... }: {
  home.packages = with pkgs; [ swaybg wideriver ];
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = builtins.readFile ./init;
  };
}
