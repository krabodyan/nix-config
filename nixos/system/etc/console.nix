{ pkgs, ... }:
{
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };
}
