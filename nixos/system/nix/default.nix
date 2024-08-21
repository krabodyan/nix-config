{ system, lib, ... }:
{
  imports = [
    ./ld.nix
    ./nh.nix
  ];
  nixpkgs.hostPlatform = lib.mkDefault system;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-substituters = [
        "https://helix.cachix.org"
        "https://mur.cachix.org"
      ];
      trusted-public-keys = [
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "mur.cachix.org-1:VncNRWnvAh+Pl71texI+mPOiwTB5267t029meC4HBC0="
      ];
      builders-use-substitutes = true;
      max-jobs = 12;
      cores = 12;
      trusted-users = [
        "krabodyan"
        "root"
      ];
      auto-optimise-store = true;
    };
  };
}
