rec {
  systemFont = "IosevkaTerm Nerd Font";

  colors = rec {
    select = brmagenta;

    border = "ffdef6";

    mode_insert = overlay1;
    mode_normal = red;
    mode_select = brmagenta;

    bg = "0A0A0A";
    bg-dark = "000000";
    bg-bright = "141414";

    surface0 = "1a1a1a";
    surface1 = "262626";
    surface2 = "2e2e2e";

    fg = "f7f6ef";
    fg-dark = "474747";
    fg-bright = "fffff7";

    overlay0 = "4d4d4d";
    overlay1 = "666666";
    overlay2 = "808080";
    subtext0 = "a6a6a1";

    black = surface1;
    red = "ef8993";
    green = "9eff75";
    yellow = "f9d481";
    blue = "80beed";
    magenta = "f595db";
    cyan = "7fe8e6";

    brblack = "363636";
    brred = "ff96b4";
    brgreen = "bdffa1";
    bryellow = "fff982";
    brblue = "89dceb";
    brmagenta = "ffbaec";
    brcyan = "86f5f3";

    orange = "f5ca69";
    peach = "f2cdcd";
    rosewater = "f5e0dc";
    teal = "94e2d5";
    sky = "89dceb";
    sapphire = "74c7ec";
  };
  colors.hex = builtins.mapAttrs (_: v: "#${v}") colors;
}
