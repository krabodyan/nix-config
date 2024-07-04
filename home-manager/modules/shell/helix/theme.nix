{ config }:
let
  mkHex = color: "#${color}";
in
{
  catppuccin_mocha = with config.colors; {
    "inherits" = "catppuccin_mocha";
    "ui.background" = { };
    "comment" = mkHex fg-dark;
  };
}
