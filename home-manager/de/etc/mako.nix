{ pkgs, config, ... }:
{
  home.packages = [ pkgs.libnotify ];
  services.mako = with config.colors; {
    enable = true;
    font = "${config.font} Medium 10";
    sort = "-time";
    layer = "overlay";
    anchor = "bottom-center";
    backgroundColor = "#${bg}ff";
    progressColor = "over #${accent}";
    textColor = "#${fg}";
    width = 400;
    height = 110;
    padding = "12,0";
    borderSize = 2;
    borderColor = "#${accent}";
    borderRadius = 8;
    icons = true;
    iconPath = "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";
    maxIconSize = 32;
    defaultTimeout = 3000;
    extraConfig = ''
      text-alignment=center
      group-by=app-name
      outer-margin=32,0

      [grouped=1]
      format=<b>%s [%g]</b>\n%b

      [urgency=low]
      border-color=#${accent}

      [urgency=normal]
      border-color=#${accent}

      [urgency=critical]
      border-color=#${red}
      default-timeout=12000
      format=<b>ERROR: %s</b>\n%b
    '';
  };
}
