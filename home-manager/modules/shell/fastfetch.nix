{ config, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "raw";
        source = "${config.home.homeDirectory}/nix-config/home-manager/modules/etc/fetch.sixel";
        width = 16;
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
        color = {
          output = "blue";
          keys = "blue";
        };
      };
      modules = [
        {
          key = "╭────╮";
          type = "custom";
        }
        {
          key = "│ os {#keys}│";
          type = "os";
          format = "{2}";
        }
        {
          key = "│ wm {#keys}│";
          type = "wm";
          format = "{2}";
        }
        {
          key = "│ sh {#keys}│";
          type = "shell";
          format = "{1}";
        }
        {
          key = "│ ed {#keys}│";
          type = "editor";
        }
        {
          key = "│ up {#keys}│";
          type = "uptime";
          format = "{2}h {3}m";
        }
        {
          key = "╰────╯";
          type = "custom";
        }
      ];
    };
  };
}
