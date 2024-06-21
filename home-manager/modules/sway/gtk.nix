{config, pkgs, ...}:
{
  home.packages = with pkgs; [
    dconf
    libsForQt5.qtstyleplugins
    papirus-icon-theme
    qt6Packages.qt6gtk2
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    gtk3
  ];

  gtk = {
    enable = true;

    font.name = "Roboto Bold 10";
    font.package = pkgs.roboto;

    iconTheme.name = "Papirus-Dark";

    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        tweaks = [ "rimless" "normal" ];
        variant = "mocha";
      };
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig = {
      gtk-decoration-layout = ":menu";
      gtk-dialogs-use-header = false;
      #gtk-cursor-theme-size = 16;
      #gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
      #gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      #gtk-xft-antialias=1;
      #gtk-xft-hinting=1;
      #gtk-xft-hintstyle="hintslight";
      #gtk-xft-rgba="none";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = ":menu";
      gtk-dialogs-use-header = false;
      #gtk-cursor-theme-size = 16;
      #gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
      #gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images = 0;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      #gtk-xft-antialias=1;
      #gtk-xft-hinting=1;
      #gtk-xft-hintstyle="hintslight";
      #gtk-xft-rgba="none";
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/default-applications/terminal" = {
        exec = "foot";
      };
    };
  };

  qt = {
    enable = true;
    #style = {
    #  name = "catppuccin-kvantum";
    #  package = pkgs.catppuccin-kvantum;
    #};
    platformTheme.name = "qtct";
  };
}
