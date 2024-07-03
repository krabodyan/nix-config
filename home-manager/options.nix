{ lib, config, ... }: {
  options = {
    font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono Nerd Font";
    };
    background-image = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/nix-config/home-manager/modules/etc/background.jpg";
    };
    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        opacity = "1";
        accent = "cba6f7";

        bg-rgba = "rgba(30, 30, 46, 1)";
        bg = "1E1E2E";
        bg-dark = "11111a";
        bg-bright = "32324d";

        fg = "cdd6f4";
        fg-dark = "70758D";
        fg-bright = "a6adc8";

        black = "222222";
        red = "FC7971";
        green = "00FF6A";
        yellow = "FADA5E";
        blue = "63e7ff";
        magenta = "bd94eb";
        cyan = "00FFDE";
        orange = "ff4f00";
        pink = "ff1181";
        peach = "fa8967";
        lightgreen = "00FF96";
      };
    };
  };
}
