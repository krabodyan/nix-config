{ config, ... }:
{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      position = "right";
      layer = "top";
      # mode = "invisible";
      # start_hidden = true;
      width = 26;
      # height = 360;
      spacing = 0;
      margin = "0";
      padding = "0";
      margin-top = 370;
      margin-bottom = 370;
      margin-right = 0;
      margin-left = 0;

      modules-left = [
        "battery"
        "network"
        "tray"
      ];
      modules-center = [
        "sway/workspaces"
        "sway/window"
      ];
      modules-right = [
        "sway/language"
        "clock"
      ];

      "sway/workspaces" = {
        format = "<span font='SymbolsNerdFont 9.5'>{icon}</span>";
        format-icons = {
          default = "󰊠"; # "󱓻";
          focused = "󰮯"; # "󱓻";
          persistent = ""; # "󱓼";
        };
        tooltip = false;
        disable-scroll = true;
        persistent-workspaces = {
          "1" = [ ];
          "2" = [ ];
          "3" = [ ];
          "4" = [ ];
          "5" = [ ];
        };
        window-rewrite = { };
      };

      "sway/window" = {
        format = "";
      };

      tray = {
        icon-size = 10;
        spacing = 8;
      };

      "sway/language" = {
        tooltip = false;
        format = "{}"; # "<span style='italic'>{}</span>";
        format-en = "us"; # "🇬🇧";
        format-ru = "ru"; # "🇷🇺";
        format-ua = "ua"; # "🇺🇦";
      };

      clock = {
        format = "{:%H\n%M}"; # "<span style='italic'>{:%H:%M}</span>";
        tooltip-format = "{calendar}";
        format-alt = "{:%d\n%m}";
        actions = {
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

      network = {
        format-wifi = "<span font='SymbolsNerdFont'>󰤨</span>";
        format-ethernet = "<span font='SymbolsNerdFont'>󰤨</span>";
        format-linked = "<span font='SymbolsNerdFont'>󰤨</span>";
        format-disconnected = "<span font='SymbolsNerdFont'>󰤭</span>";
        format-disabled = "<span font='SymbolsNerdFont'>󰤭</span>";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        tooltip-format-disconnected = "disconnected";
        tooltip-format-disabled = "disabled";
      };

      battery = {
        format = "<span font='SymbolsNerdFont'>{icon}</span>";
        format-alt = "{capacity}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
    };

    style = with config.colors; ''
      * {
        all: unset;
        min-height: 0;
        border: none;
        font-family: JetBrainsMono Nerd Font;
        font-weight: bold;
        font-size: 11px;
        padding: 0;
        margin: 0;
      }

      window#waybar,
      window#waybar.solo {
        background: rgba(30, 30, 46, 1);
      }

      window#waybar.stacked,
      window#waybar.tabbed {
        background: red;
      }

      window#waybar.foot {
        background: rgba(30, 30, 46, 0.9);
      }

      window#waybar.empty,
      window#waybar.tiled,
      window#waybar.floating {
        background: transparent;
      }      

      #language,
      #tray,
      #clock,
      #network,
      #battery,
      #workspaces button
      {
        color: #${fg};
        padding: 0;
        margin: 5px 0;
      }

      #clock {
        font-size: 10px;
      }

      #language {
        font-size: 10px;
      }

      #battery {
        font-size: 10px;
      }

      #workspaces button,
      #workspaces button.persistent {
        color: #${fg-dark};
      }

      #workspaces button.focused {
        color: #${fg};
      }

      #workspaces button.urgent {
        color: #${red};
      }

      tooltip,
      #tray menu {
        border: solid #${accent} 2px;
        border-radius: 8px;
        padding: 8px 0;
        background-color: #${bg};
      }

      #tray menu menuitem {
        border-radius: 6px;
        padding: 4px 10px;
        margin: 0 8px;
      }

      #tray menu menuitem:hover {
        background-color: #${bg-bright};
      }
    '';
  };
}
