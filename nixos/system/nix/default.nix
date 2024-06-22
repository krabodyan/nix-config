{
  nix = {
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates     = [ "weekly" ];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = 1;
      cores = 12;
      trusted-users = [ "krabodyan" "root" ];
    };
  };
}
