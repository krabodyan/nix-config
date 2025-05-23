{
  lib,
  self,
  pkgs,
  config,
  username,
  hostname,
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
    environment.sessionVariables.SOPS_AGE_KEY_FILE = "/etc/sops-nix/keys.txt";
    sops = {
      defaultSopsFile = "${self}/secrets/${hostname}/secrets.yaml";
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/sops-nix/keys.txt";
      secrets.password.neededForUsers = true;
    };

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
          hashedPasswordFile = config.sops.secrets.password.path;
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
          hashedPasswordFile = config.sops.secrets.password.path;
        };
      };
    };
  };
}
