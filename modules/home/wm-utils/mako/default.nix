{
  lib,
  pkgs,
  fonts,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.mako;
in {
  options = {
    module.mako = {
      enable = mkEnableOption "enable mako";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.libnotify];
    services.mako = with colors.hex; {
      enable = true;
      font = "${fonts.monospace} SemiBold 11";
      sort = "-time";
      layer = "overlay";
      anchor = "bottom-center";
      backgroundColor = bg;
      progressColor = "over ${overlay0}";
      textColor = fg;
      width = 400;
      height = 110;
      padding = "12,0";
      borderSize = 2;
      borderColor = overlay0;
      borderRadius = 8;
      maxIconSize = 32;
      defaultTimeout = 3000;
      extraConfig = ''
        icons=0
        text-alignment=center
        group-by=app-name
        outer-margin=32,0

        [grouped=1]
        format=<b>%s [%g]</b>\n%b

        [urgency=critical]
        border-color=${red}
        default-timeout=12000

        [app-name="foot" urgency="normal"]
        border-color=${green}

        [app-name="foot"]
        on-notify=exec ${pkgs.pipewire}/bin/pw-cat -p ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga &

        [app-name="swaynotify"]
        on-notify=exec ${pkgs.pipewire}/bin/pw-cat -p ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga &
      '';
    };
  };
}
