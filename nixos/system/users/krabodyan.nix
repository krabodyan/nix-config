{ pkgs, ... }: {
  users.groups.plugdev = { };
  users.groups.netdev = { };
  users.users.krabodyan = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "krabodyan";
    extraGroups =
      [ "audio" "video" "wheel" "plugdev" "netdev" "input" "docker" "uucp" ];
    initialHashedPassword =
      "$6$zrplm9USsp0GLUsp$r.OsKXdabd23VoF3S/vja049G9NgdzEeXfdVGP.rYtwUQgv5CHu.hDZmY2zeMryFQ/fVpCkIRfYSuB1Y2H7hh0";
  };
}
