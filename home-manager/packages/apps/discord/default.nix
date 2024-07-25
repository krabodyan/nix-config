{ pkgs, config, ... }:
let
  Vesktop = pkgs.vesktop; # pkgs.callPackage ./overlay.nix {};
in
{
  home.packages = [ Vesktop ];
  xdg.configFile."vesktop/settings/quickCss.css".text = ''
    @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
    * {
        font-family: "${config.font}" !important;
        font-size: 15px !important;
        font-weight: 500 !important;
    }
  '';
}
