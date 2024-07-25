{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.pfetch-rs ];
    sessionVariables = {
      PF_COLOR = 0;
      PF_SEP = " ";
      PF_INFO = "ascii title os de shell editor uptime";
    };
  };
}
