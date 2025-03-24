{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.eza;
in {
  options = {
    module.eza = {
      enable = mkEnableOption "enables eza";
    };
  };
  config = mkIf cfg.enable {
    programs.fish.shellAliases = let
      eza = "${pkgs.eza}/bin/eza --group-directories-first --long --git";
    in rec {
      l = "${eza} --no-filesize --no-user --no-time --no-permissions";
      ls = "${l} --git-ignore";
      la = "${ls} -a";
      ll = "${eza} --octal-permissions --no-permissions";
      lla = "${eza} --octal-permissions --no-permissions -a";
      tree = "${eza} --tree";
    };
    home.packages = [pkgs.eza];
  };
}
