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
      settings = let
        beep = "exec ${pkgs.pipewire}/bin/pw-cat -p ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga &";
      in {
        icons = 0;
        markup = 0;
        font = "${fonts.monospace} SemiBold 11";
        sort = "-time";
        layer = "overlay";
        group-by = "app-name";
        anchor = "bottom-center";
        output = "eDP-1";

        text-color = fg;
        background-color = bg;
        border-color = overlay0;
        progress-color = "over ${overlay0}";

        width = 400;
        height = 110;
        border-size = 2;
        padding = "12,0";
        border-radius = 8;
        default-timeout = 3000;
        text-alignment = "center";
        outer-margin = "40,0";

        "grouped=1" = {
          format = "<b>%s [%g]</b>\\n%b";
        };

        "urgency=critical" = {
          border-color = brred;
          default-timeout = 12000;
        };

        "app-name=foot urgency=normal" = {
          border-color = brgreen;
        };

        "app-name=foot" = {
          on-notify = beep;
        };

        "app-name=swaynotify" = {
          on-notify = beep;
        };
      };
    };
  };
}
