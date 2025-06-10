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
    programs.home-manager.enable = true;

    users = {
      mutableUsers = false;

      users = {
        root = {
          shell = pkgs.bash;
          hashedPasswordFile = config.age.secrets.password.path;
          packages = with pkgs; [
            git
            helix
            nh
          ];
        };

        ${username} = {
          inherit (config.users.users.root) packages;
          uid = 1000;
          home = "/home/${username}";
          shell = pkgs.fishMinimal;
          isNormalUser = true;
          description = "${username}";
          extraGroups = [
            "audio"
            "video"
            "wheel"
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
