{ lib, config, ... }:
{
  options = {
    font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono Nerd Font"; # "IosevkaTerm Nerd Font";
    };
    background-image = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/assets/background.jpg";
    };
    swaylock-image = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/assets/swaylock.jpg";
    };
    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = rec {
        accent = fg;

        bg = "151515";
        bg-dark = "0f0f0f";
        bg-bright = "1a1a1a";

        surface0 = "1f1f1f";
        surface1 = "303030";
        surface2 = "383838";

        fg = "e6dede";
        fg-dark = "474747";
        fg-bright = "f5ecec";

        subtext0 = "bfb9b9";
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
        brred = "e67e81";
        brgreen = "92f2b3";
        bryellow = "f9e8c0";
        brblue = "80cfed";
        brmagenta = "ec91f2";
        brcyan = "75e6e3";

        orange = "eba0ac";
        pink = "f5c2e7";
        peach = "f2cdcd";
        mantle = "181825";
        rosewater = "f5e0dc";
      };
    };
  };
}
