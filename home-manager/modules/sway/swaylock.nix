{ pkgs, config, ... }: {
  programs.swaylock = {
    enable = true;
    settings =
    let
      col = config.colors;
      t = "00000000";
    in {
      font = config.font;
      image = config.background-image;
      daemonize = true;

      color = col.bg;
      inside-color = t;
      line-color = col.fg;
      key-hl-color = col.fg;
      separator-color = t;
      bs-hl-color = col.pink;

      inside-clear-color = t;
      inside-caps-lock-color = t;
      inside-ver-color = t;
      inside-wrong-color = t;

      ring-color = t;
      ring-clear-color = col.yellow;
      ring-caps-lock-color = col.red;
      ring-ver-color = col.cyan;
      ring-wrong-color = col.red;

      text-color = col.fg;
      text-caps-lock-color = col.fg;
      text-clear-color = col.fg;
      text-ver-color = col.fg;
      text-wrong-color = col.fg;

      layout-bg-color = t;
      layout-border-color = t;
      layout-text-color = col.fg;

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
