{ config, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "raw";
        source = "${config.home.homeDirectory}/nix-config/assets/fetch.sixel";
        width = 16;
        height = 9;
        padding = {
          top = 0;
          left = 2;
          right = 1;
        };
      };
      display = {
        separator = "";
        key.width = 8;
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
