{ config, pkgs, ... }:
{
  imports = [
    ./cursor.nix
    ./qtct.nix
  ];
  home.packages = [ pkgs.dconf ];
  gtk = {
    enable = true;

    font = {
      name = "Roboto Bold";
      size = 10;
      package = pkgs.roboto;
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      name = "Papirus-Dark";
    };

    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "compact";
        tweaks = [
          "rimless"
          "normal"
        ];
        variant = "mocha";
      };
      name = "catppuccin-mocha-lavender-compact+rimless,normal";
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3 = {
      extraConfig = {
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-application-prefer-dark-theme = 1;
      };
      extraCss = with config.colors; ''
        menu,
        tooltip {
          background-color: #${surface0};
          border-radius: 5px;
          text-shadow: none;
        }

        tooltip {
          background-color: #${surface1};
        }

        menu menuitem:hover {
          background-color: #${surface1};
          border-radius: 5px;
          text-shadow: none;
        }

        .titlebar,
        messagedialog.csd decoration,
        .titlebar .background,
        decoration,
        window,
        window.background
        {
            border-radius: 0;
        }

        decoration, decoration:backdrop
        {
            box-shadow: none;
        }
      '';
    };

    gtk4 = {
      extraConfig = config.gtk.gtk3.extraConfig;
      extraCss = config.gtk.gtk3.extraCss;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile =
    let
      variant = "Mocha";
      accent = "Lavender";
      kvantumThemePackage = pkgs.catppuccin-kvantum.override { inherit variant accent; };
    in
    {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Catppuccin-${variant}-${accent}
      '';
      "Kvantum/Catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/Catppuccin-${variant}-${accent}";
    };
}
