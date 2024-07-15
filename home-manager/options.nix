{ lib, config, ... }:
{
  options = {
    font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono Nerd Font";
    };
    background-image = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/home-manager/modules/etc/background.jpg";
    };
    swaylock-image = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/home-manager/modules/etc/swaylock.jpg";
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
        bg-bright = "32324d";

        fg = "a0aae3";
        fg-dark = "616991";
        fg-bright = "a6adc8";

        black = "45475a";
        red = "f38ba8";
        green = "21d98e";
        yellow = "f9e2af";
        blue = "89b4fa";
        magenta = "cba6f7";
        cyan = "74c7ec";
        orange = "eba0ac";
        pink = "f5c2e7";
        peach = "f2cdcd";
      };
    };
  };
}
