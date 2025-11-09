rec {
  fonts = {
    monospace = "IosevkaTerm NF";
    serif = "Roboto Medium";
  };

  colors = rec {
    select = brmagenta;

    border = overlay0;

    mode_insert = overlay1;
    mode_normal = brred;
    mode_select = brmagenta;

    bg = "0f0f0f";
    bg-dark = "000000";
    bg-bright = "141414";

    surface0 = "1a1a1a";
    surface1 = "262626";
    surface2 = "2e2e2e";
    surface3 = "424242";

    fg = "f7f6ef";
    fg-dark = "474747";
    fg-bright = "fffff7";

    overlay0 = "4d4d4d";
    overlay1 = "595959";
    overlay2 = "666666";
    subtext0 = "999999";

    black = surface2;
    red = "c43f3f";
    green = "9eff75";
    yellow = "f4dc75";
    blue = "80beed";
    magenta = "f595db";
    cyan = "7fe8e6";

    brblack = overlay1;
    brred = "ef8993";
    brgreen = "b7ff99";
    bryellow = "f9e381";
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
