{
  _module.args.theme = rec {
    font = "IosevkaTerm Nerd Font";

    colors = rec {
      select = brpink;

      border = "ffdef6";

      mode_insert = yellow;
      mode_normal = red;
      mode_select = brmagenta;

      bg = "0A0A0A";
      bg-dark = "000000";
      bg-bright = "141414";

      surface0 = "1a1a1a";
      surface1 = "262626";
      surface2 = "2e2e2e";
      surface3 = "383838";

      fg = "f7f6ef";
      fg-dark = "474747";
      fg-bright = "fffff7";

      overlay0 = "4d4d4d";
      overlay1 = "666666";
      overlay2 = "808080";
      subtext0 = "a6a6a1";

      black = fg-dark;
      red = "EF8993";
      green = "67e692";
      yellow = "f9e289";
      blue = "80beed";
      magenta = "ee7cec";
      cyan = "77d9d7";

      brblack = overlay0;
      brred = "ff96b4";
      brgreen = "99f7ba";
      bryellow = "ffeec7";
      brblue = cyan;
      brmagenta = "f6affa";
      brcyan = "75e6e3";

      orange = "eba0ac";
      pink = "f595db";
      brpink = "ffcaf0";
      peach = "f2cdcd";
      rosewater = "f5e0dc";
      teal = "94e2d5";
      sky = "89dceb";
      sapphire = "74c7ec";
    };

    colorsHex = builtins.mapAttrs (_: v: "#${v}") colors;
  };
}
