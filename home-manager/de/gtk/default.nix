{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./cursor.nix
    ./qtct.nix
  ];
  home.packages = with pkgs; [
    dconf
    colloid-kde
  ];
  gtk = {
    enable = true;

    font = {
      name = "Roboto Bold";
      size = 10;
      package = pkgs.roboto;
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-black-dark";
    };

    theme = {
      package = pkgs.graphite-gtk-theme.override {
        colorVariants = [ "dark" ];
        themeVariants = [ "default" ];
        tweaks = [
          "rimless"
          "normal"
          "darker"
        ];
      };
      name = "Graphite-Dark";
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
          background-color: #${surface1};
          border-radius: 5px;
          text-shadow: none;
        }

        tooltip {
          background-color: #${surface2};
        }

        menu menuitem:hover {
          color: #${fg}
          background-color: #${surface2};
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
    enable = false;
  };
}
