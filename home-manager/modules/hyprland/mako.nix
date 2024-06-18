{ pkgs, config, ... }: {
  home.packages = [ pkgs.libnotify ];
  services.mako = {
    enable = true;
    font = "${config.font} Bold 10";
    sort = "-time";
    layer = "overlay";
    anchor = "bottom-center";
    backgroundColor = "#${config.colors.bg}ff"; #e6
    progressColor = "over #${config.colors.accent}";
    textColor = "#${config.colors.fg}";
    width = 360;
    height = 110;
    padding = "12,0";
    borderSize = 2;
    borderColor = "#${config.colors.accent}";
    borderRadius = 12;
    iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
    maxIconSize = 32;
    defaultTimeout = 3000;
    extraConfig = ''
      text-alignment=center
      group-by=app-name
      outer-margin=32,0

      [grouped=1]
      format=<b>%s [%g]</b>\n%b

      [urgency=low]
      border-color=#${config.colors.accent}

      [urgency=normal]
      border-color=#${config.colors.accent}

      [urgency=critical]
      border-color=#${config.colors.red}
      default-timeout=12000
      format=<b>ERROR: %s</b>\n%b
    '';
  };
}
