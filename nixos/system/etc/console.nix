{ pkgs, config, ... }:
{
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v22b.psf.gz";
    packages = [ pkgs.terminus_font ];
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
