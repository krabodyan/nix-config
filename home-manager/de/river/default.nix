{ pkgs, ... }: {
  home.packages = with pkgs; [ swaybg wideriver ];
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    # systemd.variables = [
    #   "WAYLAND_DISPLAY"
    #   "XDG_CURRENT_DESKTOP"
    #   "NIXOS_OZONE_WL"
    #   "XCURSOR_THEME"
    #   "XCURSOR_SIZE"
    #   "DBUS_SESSION_BUS_ADDRESS"
    # ];
    # extraSessionVariables = { XDG_CURRENT_DESKTOP = "river"; };
    extraConfig = builtins.readFile ./init;
  };
}
