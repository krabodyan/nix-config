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
      eza = "${pkgs.eza}/bin/eza --group-directories-first --long --git --sort ext";
    in rec {
      ls = "${eza} --no-filesize --no-user --no-time --no-permissions";
      la = "${ls} -a";
      lt = "${ls} --tree";
      ll = "${eza}";
      lla = "${eza} -a";
    };
    home.packages = [pkgs.eza];
  };
}
