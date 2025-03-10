{
  platform,
  lib,
  ...
}: {
  imports = [./ld.nix];
  nixpkgs.hostPlatform = lib.mkDefault platform;
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
      builders-use-substitutes = true;
      max-jobs = 12;
      cores = 12;
      trusted-users = ["krabodyan" "root"];
      auto-optimise-store = true;
    };
  };
}
