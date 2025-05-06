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
      enable = mkEnableOption "enables nix with gc";
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
      package = pkgs.lix;
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
      gc.automatic = false;

      optimise = {
        automatic = true;
        dates = ["weekly"];
      };

      settings = {
        warn-dirty = false;
        experimental-features = ["nix-command" "flakes"];
        builders-use-substitutes = true;
        auto-optimise-store = true;

        substituters = [
          "https://helix.cachix.org"
          "https://nixpkgs-wayland.cachix.org"
          "https://cache.nixos.org"
          "https://chaotic-nyx.cachix.org/"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
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
