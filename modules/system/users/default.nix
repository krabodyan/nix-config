{
  lib,
  self,
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
      mutableUsers = true;

      groups = {
        plugdev = {};
        netdev = {};
      };

      users = {
        root = {
          shell = pkgs.fish;
          hashedPasswordFile = "${self}/secrets/password";
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
          hashedPasswordFile = "${self}/secrets/password";
        };
      };
    };
  };
}
