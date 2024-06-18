{ lib, ...}: {
  options = {
    font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono Nerd Font";
    };
    background-image = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/nix-config/home-manager/modules/misc/background.jpg";
    };
    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        opacity    = "1";
        # border     = "94e2d5"; # e5678b";
        accent     = "cba6f7";

        bg-rgba    = "rgba(30, 30, 46, 1)";
        bg         = "1E1E2E";
        bg-dark    = "11111a";
        bg-bright  = "32324d";

        fg         = "cdd6f4";
        fg-dark    = "6c7086";
        fg-bright  = "a6adc8";

        black      = "222222";
        red        = "FC7971";
        green      = "47fd2a";
        yellow     = "FADA5E";
        blue       = "63e7ff";
        magenta    = "bd94eb";
        cyan       = "94e2d5";
        orange     = "ff771e";
        pink       = "ff1181";
        peach      = "fa8967";
        lightgreen = "A6E3A1";
      };
    };
  };
}
