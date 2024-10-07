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
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      name = "Papirus-Dark";
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
      # extraCss = with config.colors; ''
      #   menu,
      #   tooltip {
      #     background-color: #${surface0};
      #     border-radius: 5px;
      #     text-shadow: none;
      #   }

      #   tooltip {
      #     background-color: #${surface1};
      #   }

      #   menu menuitem:hover {
      #     background-color: #${surface1};
      #     border-radius: 5px;
      #     text-shadow: none;
      #   }

      #   .titlebar,
      #   messagedialog.csd decoration,
      #   .titlebar .background,
      #   decoration,
      #   window,
      #   window.background
      #   {
      #       border-radius: 0;
      #   }

      #   decoration, decoration:backdrop
      #   {
      #       box-shadow: none;
      #   }

      #   @define-color accent_color #${accent};
      #   @define-color accent_bg_color #${accent};

      #   @define-color destructive_color #${red};
      #   @define-color destructive_bg_color #${red};
      #   @define-color destructive_fg_color #${bg};
      #   @define-color success_color #${green};
      #   @define-color success_bg_color #${green};
      #   @define-color success_fg_color #${bg};
      #   @define-color warning_color #${pink};
      #   @define-color warning_bg_color #${pink};
      #   @define-color warning_fg_color #${bg};
      #   @define-color error_color #${red};
      #   @define-color error_bg_color #${red};
      #   @define-color error_fg_color #${bg};
      #   @define-color window_bg_color #${bg};
      #   @define-color window_fg_color #${fg};
      #   @define-color view_bg_color #${bg};
      #   @define-color view_fg_color #${fg};
      #   @define-color headerbar_bg_color #${bg-bright};
      #   @define-color headerbar_fg_color #${fg};
      #   @define-color headerbar_border_color rgba(0, 0, 0, 0.7);
      #   @define-color headerbar_backdrop_color @window_bg_color;
      #   @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
      #   @define-color headerbar_darker_shade_color rgba(0, 0, 0, 0.07);
      #   @define-color sidebar_bg_color #${bg-bright};
      #   @define-color sidebar_fg_color #${fg};
      #   @define-color sidebar_backdrop_color @window_bg_color;
      #   @define-color sidebar_shade_color rgba(0, 0, 0, 0.07);
      #   @define-color secondary_sidebar_bg_color @sidebar_bg_color;
      #   @define-color secondary_sidebar_fg_color @sidebar_fg_color;
      #   @define-color secondary_sidebar_backdrop_color @sidebar_backdrop_color;
      #   @define-color secondary_sidebar_shade_color @sidebar_shade_color;
      #   @define-color card_bg_color #${bg-bright};
      #   @define-color card_fg_color #${fg};
      #   @define-color card_shade_color rgba(0, 0, 0, 0.07);
      #   @define-color dialog_bg_color #${bg-bright};
      #   @define-color dialog_fg_color #${fg};
      #   @define-color popover_bg_color #${bg-bright};
      #   @define-color popover_fg_color #${fg};
      #   @define-color popover_shade_color rgba(0, 0, 0, 0.07);
      #   @define-color shade_color rgba(0, 0, 0, 0.07);
      #   @define-color scrollbar_outline_color #${red};
      #   @define-color blue_1 #${blue};
      #   @define-color blue_2 #${blue};
      #   @define-color blue_3 #${blue};
      #   @define-color blue_4 #${blue};
      #   @define-color blue_5 #${blue};
      #   @define-color green_1 #${green};
      #   @define-color green_2 #${green};
      #   @define-color green_3 #${green};
      #   @define-color green_4 #${green};
      #   @define-color green_5 #${green};
      #   @define-color yellow_1 #${yellow};
      #   @define-color yellow_2 #${yellow};
      #   @define-color yellow_3 #${yellow};
      #   @define-color yellow_4 #${yellow};
      #   @define-color yellow_5 #${yellow};
      #   @define-color orange_1 #${orange};
      #   @define-color orange_2 #${orange};
      #   @define-color orange_3 #${orange};
      #   @define-color orange_4 #${orange};
      #   @define-color orange_5 #${orange};
      #   @define-color red_1 #${red};
      #   @define-color red_2 #${red};
      #   @define-color red_3 #${red};
      #   @define-color red_4 #${red};
      #   @define-color red_5 #${red};
      #   @define-color purple_1 #${pink};
      #   @define-color purple_2 #${pink};
      #   @define-color purple_3 #${pink};
      #   @define-color purple_4 #${pink};
      #   @define-color purple_5 #${pink};
      #   @define-color brown_1 #${magenta};
      #   @define-color brown_2 #${magenta};
      #   @define-color brown_3 #${magenta};
      #   @define-color brown_4 #${magenta};
      #   @define-color brown_5 #${magenta};
      #   @define-color light_1 #${bg-bright};
      #   @define-color light_2 #${bg-bright};
      #   @define-color light_3 #${bg-bright};
      #   @define-color light_4 #${bg-bright};
      #   @define-color light_5 #${bg-bright};
      #   @define-color dark_1 #${bg-bright};
      #   @define-color dark_2 #${bg-bright};
      #   @define-color dark_3 #${bg-bright};
      #   @define-color dark_4 #${bg-bright};
      #   @define-color dark_5 #${bg-bright};
      # '';
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
