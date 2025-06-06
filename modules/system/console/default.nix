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
      enable = mkEnableOption "console font and colors";
    };
  };
  config = mkIf cfg.enable {
    console = {
      earlySetup = true;
      font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v22b.psf.gz";
      keyMap = "us";
      colors = with colors; [
        bg
        red
        green
        yellow
        blue
        magenta
        cyan
        fg
        brblack
        brred
        brgreen
        bryellow
        brblue
        brmagenta
        cyan
        fg-bright
      ];
    };
  };
}
