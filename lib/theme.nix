{ config, ... }: {
  _module.args.theme = rec {
    background-image =
      "${config.home.homeDirectory}/flake/assets/background.jpg";
    font = "IosevkaTerm Nerd Font";

    select = pink;
    border = "ffdef6";

    mode_normal = blue;
    mode_insert = yellow;
    mode_select = red;
    yazi_select = pink;

    bg = "0A0A0A";
    bg-dark = "000000";
    bg-bright = "0f0f0f";

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
    magenta = "DC8EC1";
    cyan = "77d9d7";

    brblack = overlay0;
    brred = "f38ba8";
    brgreen = "92f2b3";
    bryellow = "ffeec7";
    brblue = "80cfed";
    brmagenta = "ec91f2";
    brcyan = "75e6e3";

    orange = "eba0ac";
    pink = "f5c2e7";
    peach = "f2cdcd";
    mantle = "181825";
    rosewater = "f5e0dc";
    teal = "94e2d5";
    sky = "89dceb";
    sapphire = "74c7ec";
  };
}
