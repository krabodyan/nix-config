{
  lib,
  pkgs,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.console;
in {
  options = {
    module.console = {
      enable = mkEnableOption "enable console font and colors";
    };
  };
  config = mkIf cfg.enable {
    console = {
      earlySetup = true;
      font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v22b.psf.gz";
      keyMap = "us";
      colors = with colors; [
        bg-dark
        red
        green
        yellow
        blue
        magenta
        cyan
        fg-bright
        bg-bright
        brred
        brgreen
        bryellow
        brblue
        brmagenta
        brcyan
        fg-bright
      ];
    };
  };
}
