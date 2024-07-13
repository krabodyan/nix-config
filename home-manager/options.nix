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
        opacity = "1";
        accent = "b4befe";
        accent-rgba = "rgba(180, 190, 254, 0.7)";

        bg-rgba = "rgba(30, 30, 46, 1)";
        bg = "1E1E2E";
        border-unfocused = "1E1E2E"; # 1c1c2b";
        bg-dark = "161621";
        bg-bright = "32324d";

        fg = "a6aee2";
        fg-dark = "616991";
        fg-bright = "a6adc8";
        fg-lavender = "7e86b3";

        black = "222222";
        red = "FC7971";
        green = "00FF6A";
        yellow = "f9e2af";
        blue = "63e7ff";
        magenta = "bd94eb";
        cyan = "00FFDE";
        orange = "ef9f76";
        pink = "ff1181";
        peach = "fa8967";
        lightgreen = "00FF96";
      };
    };
  };
}
