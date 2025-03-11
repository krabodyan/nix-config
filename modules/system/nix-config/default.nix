{
  lib,
  config,
  system,
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
      gc.automatic = false;
      optimise = {
        automatic = true;
        dates = ["weekly"];
      };
      settings = {
        warn-dirty = false;
        experimental-features = ["nix-command" "flakes"];
        # builders-use-substitutes = true;

        substituters = ["https://helix.cachix.org" "https://nixpkgs-wayland.cachix.org"];

        trusted-public-keys = [
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        ];

        allowed-users = ["@wheel"];

        trusted-users = [
          "root"
          username
        ];

        auto-optimise-store = true;
      };
    };
  };
}
