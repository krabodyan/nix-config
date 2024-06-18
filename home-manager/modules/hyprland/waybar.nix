{ pkgs, config, inputs, ... }: {
  programs.waybar = {
    enable = true;
    # package = inputs.waybar.packages.${pkgs.system}.waybar;

    settings.mainBar = {
      position = "right";
      layer = "top";
      start_hidden = false;
      width = 26;
      height = 360;
      spacing = 0;
      margin = "0";
      padding = "0";
      margin-right = 8;

      modules-left = [ "battery" "network" "tray" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "hyprland/language" "clock" ];

      "hyprland/workspaces" = {
        format = "<span font='SymbolsNerdFont'>{icon}</span>";
        format-icons = {
          default = "󱓻";
          active = "󱓻";
          empty = "󱓼";
        };
        tooltip = false;
        persistent-workspaces = { "*" = 5; };
      };

      tray = {
        icon-size = 10;
        spacing = 8;
      };

      "hyprland/language" = {
        format = "{}"; # "<span style='italic'>{}</span>";
        format-en = "us"; #"🇬🇧";
        format-ru = "ru"; #"🇷🇺";
        format-uk = "ua"; #"🇺🇦";
      };

      clock = {
        format = "{:%H\n%M}"; #"<span style='italic'>{:%H:%M}</span>";
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
        format-icons = ["" "" "" "" ""];
      };
    };

    style = ''
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

      window#waybar {
        background-color: #${config.colors.bg};
        border-radius: 8px;
      }

      #language,
      #tray,
      #clock,
      #network,
      #battery,
      #workspaces button
      {
        color: #${config.colors.fg-bright};
        padding: 0;
        margin: 5px 0;
      }

      #clock {
        font-size: 10px;
        margin-bottom: 10px;
      }

      #language {
        font-size: 10px;
      }

      #battery {
        font-size: 10px;
        margin-top: 10px;
      }

      #workspaces button,
      #workspaces button.empty {
        color: #${config.colors.fg-dark};
      }

      #workspaces button.active,
      #workspaces button.active.empty,
      #workspaces button:hover {
        color: #${config.colors.fg};
      }

      #workspaces button.urgent {
        color: #${config.colors.red};
      }

      tooltip,
      #tray menu {
        border: solid #${config.colors.accent} 2px;
        border-radius: 8px;
        padding: 8px 0;
        background-color: #${config.colors.bg};
      }

      #tray menu menuitem {
        border-radius: 6px;
        padding: 4px 10px;
        margin: 0 8px;
      }

      #tray menu menuitem:hover {
        background-color: #${config.colors.bg-bright};
      }
    '';
  };
}
