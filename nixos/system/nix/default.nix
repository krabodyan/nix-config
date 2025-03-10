{
  system,
  lib,
  ...
}: {
  imports = [./ld.nix];
  nixpkgs.hostPlatform = lib.mkDefault system;
  nix = {
    gc = {
      automatic = false;
      # dates = "weekly";
      # options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    settings = {
      warn-dirty = false;
      experimental-features = ["nix-command" "flakes"];
      builders-use-substitutes = true;
      max-jobs = 12;
      cores = 12;
      trusted-users = ["krabodyan" "root"];
      auto-optimise-store = true;
    };
  };
}
