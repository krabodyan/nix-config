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
      useBabelfish = true;
    };

    programs.command-not-found.enable = false;

    users = {
      mutableUsers = false;

      users = let
        basePackages = with pkgs; [
          git
          helix
          nh
          home-manager
        ];
      in {
        root = {
          shell = pkgs.bash;
          hashedPasswordFile = config.age.secrets.password.path;
          packages = basePackages;
        };

        ${username} = {
          uid = 1000;
          home = "/home/${username}";
          shell = pkgs.fishMinimal;
          packages = basePackages;
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
