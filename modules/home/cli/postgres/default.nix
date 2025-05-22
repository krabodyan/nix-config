{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.postgres-cli;
in {
  options = {
    module.postgres-cli = {
      enable = mkEnableOption "enables postgres-cli";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      postgresql
    ];
    home.file.".psqlrc".text = ''
      \set QUIET ON
      \pset null '-'

      \set PROMPT1 '%[%033[95m%]%n@%/%[%033[0m%]%# '
      \set PROMPT2 '%[%033[95m%]... : %[%033[0m%]'

      \pset pager 0
      \pset border 2
      \pset linestyle unicode
      \pset format aligned
      \pset tuples_only off
    '';
  };
}
