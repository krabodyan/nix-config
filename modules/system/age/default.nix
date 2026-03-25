{
  lib,
  system,
  inputs,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.agenix;
in {
  options = {
    module.agenix = {
      enable = mkEnableOption "agenix";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.agenix.packages.${system}.default
    ];
    age = {
      identityPaths = ["/etc/ssh/agekey"];
      secrets = {
        password = {
          file = ../../../secrets/password.age;
        };
        ssh-ed25519 = {
          file = ../../../secrets/ssh_ed25519.age;
          path = "/home/${username}/.ssh/id_ed25519";
          mode = "400";
          symlink = false;
          owner = username;
        };
        ssh-rsa = {
          file = ../../../secrets/ssh_rsa.age;
          path = "/home/${username}/.ssh/id_rsa";
          mode = "400";
          symlink = false;
          owner = username;
        };
      };
    };
  };
}
