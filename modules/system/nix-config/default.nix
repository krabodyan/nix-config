{
  lib,
  pkgs,
  config,
  system,
  inputs,
  username,
  stateVersion,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.nix-config;
in {
  options = {
    module.nix-config = {
      enable = mkEnableOption "some nix settings";
    };
  };
  config = mkIf cfg.enable {
    system = {
      inherit stateVersion;
    };
    nixpkgs.hostPlatform = system;
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecurePredicate = _: true;
    };

    nix = {
      package = pkgs.lixPackageSets.latest.lix;
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
      gc.automatic = false;

      optimise = {
        automatic = true;
        dates = ["weekly"];
        randomizedDelaySec = "30min";
      };

      settings = {
        warn-dirty = false;
        experimental-features = ["nix-command" "flakes"];
        builders-use-substitutes = true;
        auto-optimise-store = true;

        substituters = [
          "https://helix.cachix.org"
          "https://cache.nixos.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        ];

        trusted-users = [
          "@wheel"
          "root"
          username
        ];
      };
    };
  };
}
