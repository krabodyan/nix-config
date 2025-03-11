{
  lib,
  config,
  username,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.users;
in {
  options = {
    module.users = {
      enable = mkEnableOption "enable users";
    };
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
    programs.command-not-found.enable = true;

    users = {
      mutableUsers = false;

      groups = {
        plugdev = {};
        netdev = {};
      };

      users = {
        root = {
          shell = pkgs.fish;
          initialHashedPassword = "$6$zrplm9USsp0GLUsp$r.OsKXdabd23VoF3S/vja049G9NgdzEeXfdVGP.rYtwUQgv5CHu.hDZmY2zeMryFQ/fVpCkIRfYSuB1Y2H7hh0";
        };

        ${username} = {
          uid = 1000;
          home = "/home/${username}";
          shell = pkgs.fish;
          isNormalUser = true;
          description = "${username}";
          extraGroups = [
            "audio"
            "video"
            "wheel"
            "plugdev"
            "netdev"
            "input"
            "docker"
            "uucp"
            "dialout"
          ];
          initialHashedPassword = "$6$zrplm9USsp0GLUsp$r.OsKXdabd23VoF3S/vja049G9NgdzEeXfdVGP.rYtwUQgv5CHu.hDZmY2zeMryFQ/fVpCkIRfYSuB1Y2H7hh0";
        };
      };
    };
  };
}
