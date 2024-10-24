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
  home.packages = [ pkgs.dconf ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "";
      };
      "org/gnome/desktop/applications/terminal" = {
        exec = "foot";
      };
    };
  };
  gtk = {
    enable = true;
    font = {
      name = "Roboto Medium";
      size = 10;
      package = pkgs.roboto;
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-yellow-dark";
    };
    theme = {
      package = pkgs.graphite-gtk-theme.override {
        colorVariants = [ "dark" ];
        themeVariants = [ "default" ];
        tweaks = [
          "rimless"
          # "normal"
          "darker"
        ];
      };
      name = "Graphite-Dark";
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };

    gtk3 = {
      extraConfig = {
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-application-prefer-dark-theme = 1;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
      };
      extraCss = with config.colors; ''
        menu,
        tooltip {
          background-color: #${surface2};
          border-radius: 5px;
          text-shadow: none;
        }

        menu menuitem:hover {
          color: #${fg};
          background-color: #${overlay0};
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
  };
}
