{ theme, ... }: {
  programs.swaylock = {
    enable = true;
    settings = with theme;
      let
        t = "00000000";
        fg = overlay1;
      in {
        inherit font;
        # image = swaylock-image;
        daemonize = true;

        color = bg;
        inside-color = t;
        line-color = fg;
        line-caps-lock-color = red;
        separator-color = t;
        key-hl-color = fg;
        caps-lock-key-hl-color = bg;
        bs-hl-color = fg;
        caps-lock-bs-hl-color = bg;

        inside-clear-color = t;
        inside-caps-lock-color = red;
        inside-ver-color = t;
        inside-wrong-color = t;

        ring-color = t;
        ring-clear-color = fg;
        ring-caps-lock-color = red;
        ring-ver-color = fg;
        ring-wrong-color = red;

        text-color = fg;
        text-caps-lock-color = bg;
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
