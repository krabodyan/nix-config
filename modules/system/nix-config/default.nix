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
      package = pkgs.nix;
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
        show-trace = true;

        substituters = [
          "https://helix.cachix.org"
          "https://cache.nixos.org"
          "https://nixpkgs-wayland.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
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
