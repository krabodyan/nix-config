{ pkgs, config, ... }:
{
  console = {
    earlySetup = true;
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v22n.psf.gz";
    keyMap = "us";
    colors = with config.colors; [
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
}
