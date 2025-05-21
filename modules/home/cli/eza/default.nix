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
      eza = "${pkgs.eza}/bin/eza --group-directories-first --long --sort ext";
    in rec {
      ls = "${eza} --no-filesize --no-user --no-time --no-permissions --ignore-glob \"target|node_modules|__pycache__\"";
      la = "${ls} -a";
      lt = "${ls} --tree";
      ll = "${eza} --group";
      lla = "${ll} -a";
    };
    home.packages = [pkgs.eza];
  };
}
