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
      use-xdg-base-directories = true;
      max-jobs = 1;
      cores = 12;
      trusted-users = [ "krabodyan" "root" ];
      auto-optimise-store = true;
    };
  };
}
