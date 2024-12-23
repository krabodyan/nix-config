{ pkgs, ... }: {
  home.packages = with pkgs; [ swaybg wideriver ];
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    extraSessionVariables = { XDG_CURRENT_DESKTOP = "river"; };
    extraConfig = builtins.readFile ./init;
  };
}
