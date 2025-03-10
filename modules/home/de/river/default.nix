{
  self,
  pkgs,
  colors,
  ...
}: {
  home.packages = with pkgs; [swaybg wideriver lswt];
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = import ./init.nix {
      inherit colors;
      background = "${self}/assets/background.jpg";
    };
  };
}
