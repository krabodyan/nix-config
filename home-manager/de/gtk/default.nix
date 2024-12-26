{ config, pkgs, ... }: {
  imports = [ ./cursor.nix ./qtct.nix ];
  home.packages = [ pkgs.dconf ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
      "org/gnome/desktop/wm/preferences" = { button-layout = ""; };
      "org/gnome/desktop/applications/terminal" = { exec = "foot"; };
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
      # package = pkgs.fluent-gtk-theme.override {
      #   themeVariants = [ "grey" ];
      #   colorVariants = [ "dark" ];
      #   sizeVariants = [ "standard" ];
      #   tweaks = [ "noborder" "square" "solid" ];
      # };
      name = "paradise-gtk";
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
        gtk-dialogs-use-header=false
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
        gtk-dialogs-use-header = false;
      };
      extraCss = ''
        window.csd,             /* gtk4? */
        window.csd decoration { /* gtk3 */
          box-shadow: none;
        }

        headerbar.default-decoration {
          /* You may need to tweak these values depending on your GTK theme */
          margin-bottom: 50px;
          margin-top: -100px;
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
