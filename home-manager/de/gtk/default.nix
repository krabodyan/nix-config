{ inputs, theme, config, pkgs, ... }: {
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
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = let
      colorScheme = {
        slug = "paradise";
        name = "paradise";
        author = "krabodyan";
        palette = with theme; {
          base00 = bg; # Фон (самый темный)
          base01 = surface0; # Темная поверхность
          base02 = bg; # Средняя поверхность
          base03 = overlay0; # Тусклый текст, элементы UI
          base04 = subtext0; # Чуть ярче, для вторичного текста
          base05 = fg; # Обычный текст
          base06 = fg-bright; # Яркий текст
          base07 = rosewater; # Самый светлый цвет, почти белый
          base08 = red; # Красный (ошибки, предупреждения)
          base09 = orange; # Оранжевый (вариативный акцент)
          base0A = yellow; # Желтый (предупреждения, метки)
          base0B = green; # Зеленый (успешные операции)
          base0C = blue; # Голубой (вариативный акцент)
          base0D = brpink; # Синий (ссылки, подсветка) # фокуc
          base0E = magenta; # Фиолетовый (спец. выделения)
          base0F = peach; # Редко используемый акцент
        };
      };
      inherit (inputs.nix-colors.lib-contrib { inherit pkgs; })
        gtkThemeFromScheme;
    in {
      name = colorScheme.slug;
      package = gtkThemeFromScheme { scheme = colorScheme; };
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
          box-shadow: none;
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
