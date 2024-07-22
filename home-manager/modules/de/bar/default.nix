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
        format = "<span font='SymbolsNerdFont 10.5'>{icon}</span>";
        format-icons = {
          default = ""; # "󰊠"; # "󱓻";
          # focused = ""; # "󰮯"; # "󱓻";
          # persistent = ""; # ""; # ""; # "󱓼";
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
        format-wifi = "<span font='SymbolsNerdFont 7'>󰤨</span>";
        format-ethernet = "<span font='SymbolsNerdFont 7'>󰤨</span>";
        format-linked = "<span font='SymbolsNerdFont 7'>󰤨</span>";
        format-disconnected = "<span font='SymbolsNerdFont 7'>󰤭</span>";
        format-disabled = "<span font='SymbolsNerdFont 7'>󰤭</span>";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        tooltip-format-disconnected = "disconnected";
        tooltip-format-disabled = "disabled";
      };

      battery = {
        format = "<span font='SymbolsNerdFont 9'>{icon}</span>";
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
        font-family: IosevkaTerm Nerd Font;
        font-weight: 800;
        font-size: 11px;
        padding: 0;
        margin: 0;
      }

      window#waybar {
        background-color: transparent; 
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
        font-size: 11px;
        margin-bottom: 10px;
      }

      #language {
        font-size: 11px;
      }

      #battery {
        margin-top: 10px;
      }

      #workspaces button {
        color: #${fg-dark};
      }

      #workspaces button.persistent {
        color: #${bg-bright};
      }

      #workspaces button.focused {
        color: #${accent};
      }

      #workspaces button.urgent {
        color: #${red};
      }

      tooltip label {
        color: #${fg};
        padding: 5px;
        font-size: 14px;
      }

      tooltip,
      #tray menu {
        border: solid #${accent} 2px;
        border-radius: 4px;
        background-color: #${bg};
      }

      #tray * {
        padding: 10px;
        font-size: 14px;
      }

      #tray menu menuitem {
        border-radius: 6px;
        padding: 4px 11px;
      }

      #tray menu menuitem:hover {
        background-color: #${bg-bright};
      }
    '';
  };
}
