{
  lib,
  pkgs,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.users;
in {
  options = {
    module.users = {
      enable = mkEnableOption "users";
    };
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      package = pkgs.fishMinimal;
    };

    programs.command-not-found.enable = false;

    users = {
      mutableUsers = false;

      groups = {
        plugdev = {};
        netdev = {};
      };

      users = {
        root = {
          shell = pkgs.bash;
          hashedPasswordFile = config.age.secrets.password.path;
        };

        ${username} = {
          uid = 1000;
          home = "/home/${username}";
          shell = pkgs.fishMinimal;
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
          hashedPasswordFile = config.age.secrets.password.path;
        };
      };
    };
  };
}
