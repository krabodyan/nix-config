{config, pkgs, ...}:
{
  imports = [
    ./cursor.nix
    ./qtct.nix
  ];
  home.packages = with pkgs; [
    dconf
    libsForQt5.qtstyleplugins
    papirus-icon-theme
    qt6Packages.qt6gtk2
    #qt6.qtwayland
    #libsForQt5.qt5.qtwayland
    #gtk3
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
      name = "catppuccin-mocha-mauve-compact+rimless,normal";
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig = {
      gtk-decoration-layout = ":menu";
      gtk-dialogs-use-header = false;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = ":menu";
      gtk-dialogs-use-header = false;
      gtk-button-images = 0;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
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
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile = 
  let
    variant = "Mocha";
    accent = "Mauve";
    kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
  in {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Catppuccin-${variant}-${accent}
    '';

    # The important bit is here, links the theme directory from the package to a directory under `~/.config`
    # where Kvantum should find it.
    "Kvantum/Catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/Catppuccin-${variant}-${accent}";
  };
}
