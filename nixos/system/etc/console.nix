{ pkgs, theme, ... }: {
  console = {
    earlySetup = true;
    font =
      "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v22b.psf.gz";
    keyMap = "us";
    colors = with theme.colors; [
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
