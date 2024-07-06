{ pkgs, ... }:
{
  imports = [ ./krabodyan.nix ];
  programs.fish.enable = true;
  programs.command-not-found.enable = true;
  programs.nix-index.enable = false;
  users.mutableUsers = false;
  users.users.root = {
    shell = pkgs.fish;
    initialHashedPassword = "$6$zrplm9USsp0GLUsp$r.OsKXdabd23VoF3S/vja049G9NgdzEeXfdVGP.rYtwUQgv5CHu.hDZmY2zeMryFQ/fVpCkIRfYSuB1Y2H7hh0";
  };
}
