{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.pfetch-rs ];
    sessionVariables = {
      PF_COL3 = 3;
      PF_INFO = "ascii title os de pkgs uptime";
      PF_COL2 = 3;
    };
  };
}
