{
  self,
  lib,
  config,
  ...
}:
{
  options = {
    font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono Nerd Font";
    };
    background-image = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/flake/assets/background.jpg";
    };
    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = rec {
        select = pink;
        border = "ffdef6"; # "ffeec7";

        mode_normal = blue;
        mode_insert = green;
        mode_select = red;
        yazi_select = pink;

        bg = "151515";
        bg-dark = "0f0f0f";
        bg-bright = "1c1c1c";

        surface0 = "1f1f1f";
        surface1 = "303030";
        surface2 = "383838";

        fg = "f2f1ea";
        fg-dark = "474747";
        fg-bright = "fffff7";

        subtext0 = "bfbfb9";
        overlay2 = "a3a3a3";
        overlay1 = "858585";
        overlay0 = "575757";

        black = fg-dark;
        red = "cc7073";
        green = "83d9a0";
        yellow = "f9e2af";
        blue = "80beed";
        magenta = "cc86d1";
        cyan = "77d9d7";

        brblack = fg-dark;
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
    };
  };
}
