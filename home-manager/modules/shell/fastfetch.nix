{ config, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "raw";
        source = "${config.home.homeDirectory}/nix-config/home-manager/modules/etc/fetch.sixel";
        width = 15;
        height = 8;
        padding = {
          top = 0;
          left = 0;
          right = 0;
        };
      };
      display = {
        separator = "";
        keyWidth = 8;
      };
      modules = [
        {
          key = "╭────╮";
          type = "custom";
        }
        {
          key = "│ {#36}os {#keys}│";
          type = "os";
          format = "{2}";
        }
        {
          key = "│ {#36}wm {#keys}│";
          type = "wm";
          format = "{2}";
        }
        {
          key = "│ {#36}sh {#keys}│";
          type = "shell";
          format = "{1}";
        }
        {
          key = "│ {#36}up {#keys}│";
          type = "uptime";
          format = "{2}h {3}m";
        }
        # {
        #   key = "│ {#36}ed {#keys}│";
        #   type = "editor";
        # }
        {
          key = "╰────╯";
          type = "custom";
        }
      ];
    };
  };
}
