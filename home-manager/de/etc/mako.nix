{ pkgs, config, ... }: {
  home.packages = [ pkgs.libnotify ];
  services.mako = with config.colors; {
    enable = true;
    font = "${config.font} SemiBold 11";
    sort = "-time";
    layer = "overlay";
    anchor = "bottom-center";
    backgroundColor = "#${bg}ff";
    progressColor = "over #${border}";
    textColor = "#${fg}";
    width = 400;
    height = 110;
    padding = "12,0";
    borderSize = 2;
    borderColor = "#${border}";
    borderRadius = 8;
    # iconPath =
    #   "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";
    maxIconSize = 32;
    defaultTimeout = 3000;
    # on-button-left=dismiss
    extraConfig = ''
      icons=0
      text-alignment=center
      group-by=app-name
      outer-margin=32,0

      [grouped=1]
      format=<b>%s [%g]</b>\n%b

      [urgency=critical]
      border-color=#${red}
      default-timeout=12000

      [app-name="foot"]
      on-notify=exec pw-cat -p ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga
    '';
  };
}
