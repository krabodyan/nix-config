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
        font-feature-settings: 
          "ss02",
          "cv14",
          "cv18",
          "cv04",
          "cv16";
        font-size: 14px !important;
        font-weight: 600 !important;
    }
  '';
}
