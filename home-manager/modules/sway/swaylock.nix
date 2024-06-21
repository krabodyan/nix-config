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

      color = col.bg;
      inside-color = t;
      line-color = col.fg;
      key-hl-color = col.fg;
      separator-color = t;
      inside-clear-color = col.lightgreen;
      inside-caps-lock-color = col.red;
      inside-ver-color = col.cyan;
      inside-wrong-color = col.red;

      ring-color = t;
      ring-clear-color = col.yellow;
      ring-caps-lock-color = col.red;
      ring-ver-color = col.red;
      ring-wrong-color = col.red;

      font-size = 14;
      ignore-empty-password = true;
      show-failed-attempts = true;

      indicator-radius = 40;
      indicator-idle-visible = false;
      indicator-thickness = 20;
      indicator-caps-lock = true;
    };
  };
}
