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
      enable = mkEnableOption "enable users";
    };
  };

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = "${self}/secrets/${hostname}/secrets.yaml";
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/sops-nix/keys.txt";
      secrets.password.neededForUsers = true;
    };
    environment.sessionVariables.SOPS_AGE_KEY_FILE = "/etc/sops-nix/keys.txt";

    programs.fish.enable = true;
    programs.command-not-found.enable = false;

    users = {
      mutableUsers = false;

      groups = {
        plugdev = {};
        netdev = {};
      };

      users = {
        root = {
          shell = pkgs.fish;
          hashedPasswordFile = config.sops.secrets.password.path;
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
          hashedPasswordFile = config.sops.secrets.password.path;
        };
      };
    };
  };
}
