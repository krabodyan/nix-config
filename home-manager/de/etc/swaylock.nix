{ config, ... }:
{
  programs.swaylock = {
    enable = true;
    settings =
      with config.colors;
      let
        t = "00000000";
      in
      {
        font = config.font;
        image = config.swaylock-image;
        daemonize = true;

        color = bg;
        inside-color = t;
        line-color = fg;
        key-hl-color = fg;
        separator-color = t;
        bs-hl-color = pink;

        inside-clear-color = t;
        inside-caps-lock-color = t;
        inside-ver-color = t;
        inside-wrong-color = t;

        ring-color = t;
        ring-clear-color = yellow;
        ring-caps-lock-color = red;
        ring-ver-color = cyan;
        ring-wrong-color = red;

        text-color = fg;
        text-caps-lock-color = fg;
        text-clear-color = fg;
        text-ver-color = fg;
        text-wrong-color = fg;

        layout-bg-color = t;
        layout-border-color = t;
        layout-text-color = fg;

        font-size = 16;
        ignore-empty-password = true;
        show-failed-attempts = false;

        indicator-radius = 70;
        indicator-idle-visible = false;
        indicator-thickness = 15;
        indicator-caps-lock = true;
      };
  };
}
