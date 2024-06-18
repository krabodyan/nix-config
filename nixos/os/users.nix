{ pkgs, ...}: {
  programs.fish.enable = true;
  programs.command-not-found.enable = true;
  programs.nix-index.enable = false;
  users.mutableUsers = false;
  users.users = {
    krabodyan = {
      shell = pkgs.fish;
      isNormalUser = true;
      description = "krabodyan";
      extraGroups = [ "audio" "video" "wheel" ];
      initialHashedPassword = "$6$zrplm9USsp0GLUsp$r.OsKXdabd23VoF3S/vja049G9NgdzEeXfdVGP.rYtwUQgv5CHu.hDZmY2zeMryFQ/fVpCkIRfYSuB1Y2H7hh0";
    };
    root = {
      shell = pkgs.fish;
      initialHashedPassword = "$6$zrplm9USsp0GLUsp$r.OsKXdabd23VoF3S/vja049G9NgdzEeXfdVGP.rYtwUQgv5CHu.hDZmY2zeMryFQ/fVpCkIRfYSuB1Y2H7hh0";
    };
  };
}
