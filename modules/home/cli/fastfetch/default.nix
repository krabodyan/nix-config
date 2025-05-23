{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.fastfetch;
in {
  options = {
    module.fastfetch = {
      enable = mkEnableOption "fastfetch";
    };
  };
  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo.type = "none";
        display = {
          separator = "";
          key.width = 8;
          color = {
            output = "white";
            keys = "white";
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
            format = "{2}";
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
  };
}
