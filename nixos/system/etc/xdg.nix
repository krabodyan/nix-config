{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "gtk";
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    wlr = {
      enable = true;
      settings = {
        screencast = {
          output_name = "eDP-1";
          max_fps = 30;
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
  };
}
