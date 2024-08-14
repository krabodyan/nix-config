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
      height = 360;
      spacing = 0;
      margin = "0";
      padding = "0";
      # margin-right = 0;
      # margin-left = 0;

      modules-left = [
        "battery"
        "network"
        "tray"
      ];
      modules-center = [ "sway/workspaces" ];
      modules-right = [
        "sway/language"
        "clock"
      ];

      "sway/workspaces" = {
        format = "<span font='SymbolsNerdFont 10'>{icon}</span>";
        format-icons = {
          default = ""; # "󰊠"; # "󱓻";
          # focused = ""; # "󰮯"; # "󱓻";
          persistent = ""; # ""; # "󱓼";
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

      tray = {
        icon-size = 10;
        spacing = 8;
      };

      "sway/language" = {
        tooltip = false;
        format = "{shortDescription}";
        format-us = "en"; # "🇬🇧";
        format-ru = "ru"; # "🇷🇺";
        format-ua = "uk"; # "🇺🇦";
      };

      clock = {
        format = "{:%H\n%M}";
        tooltip-format = "{calendar}";
        format-alt = "{:%d\n%m}";
        actions = {
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
        calendar.format.today = "<span color='#${config.colors.red}'>{}</span>";
      };

      network = {
        format-wifi = "<span font='SymbolsNerdFont 8'>󰤨</span>";
        format-ethernet = "<span font='SymbolsNerdFont 8'>󰤨</span>";
        format-linked = "<span font='SymbolsNerdFont 8'>󰤨</span>";
        format-disconnected = "<span font='SymbolsNerdFont 8'>󰤭</span>";
        format-disabled = "<span font='SymbolsNerdFont 8'>󰤭</span>";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        tooltip-format-disconnected = "disconnected";
        tooltip-format-disabled = "disabled";
      };

      battery = {
        format = "<span font='SymbolsNerdFont 9'>{icon}</span>";
        format-alt = "{capacity}";
        tooltip-format = "{time} | {capacity} %";
        tooltip-format-full = "{capacity} %";
        format-icons = rec {
          discharging = [
            "󰁺"
            "󰁽"
            "󰂀"
            "󰂂"
          ];
          charging = [ "" ];
          plugged = [ "󰁹" ];
          full = plugged;
        };
        states = {
          warning = 20;
          critical = 10;
        };
      };
    };

    style = with config.colors; ''
      * {
        all: unset;
        min-height: 0;
        border: none;
        font-family: ${config.font};
        font-weight: 700;
        font-size: 11px;
        padding: 0;
        margin: 0;
      }

      window#waybar {
        background-color: transparent; 
      }

      #language,
      #clock,
      #network,
      #battery,
      #workspaces button
      {
        color: #757ba6;
        padding: 0;
        margin: 5px 0;
      }

      #clock {
        margin-bottom: 10px;
      }

      #battery {
        margin-top: 10px;
      }

      #battery.critical {
        color: #${red};
      }

      #battery.warning {
        color: #${orange};
      }

      #workspaces button {
        color: #${fg-dark};
      }

      #workspaces button.persistent {
        color: #${fg-dark};
      }

      #workspaces button.focused {
        color: #${fg};
      }

      #workspaces button.urgent {
        color: #${red};
      }

      tooltip label {
        color: #${fg};
        padding: 5px;
      }

      tooltip,
      #tray menu {
        border: solid #${accent} 2px;
        border-radius: 4px;
        background-color: #${bg};
      }

      #tray {
        padding: 0;
        color: #${fg};
        margin: 5px 0;
      }

      #tray menu {
        padding: 8px 0;
      }

      tooltip label {
        font-size: 14px;
      }

      #tray * {
        font-size: 13px;
      }

      #tray menu menuitem {
        border-radius: 4px;
        margin: 2px 10px;
        padding: 3px 8px;
      }

      #tray menu menuitem:hover {
        background-color: #${bg-bright};
      }
    '';
  };
}
