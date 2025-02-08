{ pkgs, theme, ... }: {
  home.packages = with pkgs; [ swaybg wideriver lswt ];
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = import ./init.nix { inherit theme; };
  };
}
