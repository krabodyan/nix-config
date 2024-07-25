{ lib, config, ... }:
{
  options = {
    font = lib.mkOption {
      type = lib.types.str;
      default = "IosevkaTerm Nerd Font";
    };
    background-image = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/home-manager/etc/background.jpg";
    };
    swaylock-image = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/home-manager/etc/swaylock.jpg";
    };
    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        opacity = "0.9";
        accent = "b4befe";
        accent-rgba = "rgba(180, 190, 254, 0.7)";

        bg-rgba = "rgba(30, 30, 46, 1)";
        bg = "1E1E2E";
        border-unfocused = "00000000";
        bg-dark = "161621";
        bg-bright = "393959";

        fg = "a0aae3";
        fg-dark = "596080";
        fg-bright = "a6adc8";

        orange = "eba0ac";
        pink = "f5c2e7";
        peach = "f2cdcd";

        black = "62698c";
        red = "f38ba8";
        green = "6fe2b9";
        yellow = "f9e2af";
        blue = "b4befe";
        magenta = "d094f7";
        cyan = "89b4fa";

        brblack = "7178a1";
        brred = "f38ba8";
        brgreen = "99ffb3";
        bryellow = "f9e2af";
        brblue = "b4befe";
        brmagenta = "daa1ff";
        brcyan = "9dabfe";

        surface0 = "313244";
        rosewater = "f5e0dc";
      };
    };
  };
}
