{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = [ "13:00" ];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      builders-use-substitutes = true;
      max-jobs = 12;
      cores = 0;
      trusted-users = [ "krabodyan" "root" ];
      auto-optimise-store = true;
    };
  };
}
