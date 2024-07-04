{ config, ... }: {
  home = {
    username = "krabodyan";
    homeDirectory = "/home/krabodyan";
    stateVersion = "24.05";
  };
  # programs.home-manager.enable = true;
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  news.display = "silent";
  imports = [
    ./modules
    ./options.nix
  ];

  xdg = {
    enable = true;
    userDirs =
      let
        appendToHomeDir = path: "${config.home.homeDirectory}/${path}";
      in
      {
        enable = true;
        desktop = appendToHomeDir "desktop";
        documents = appendToHomeDir "documents";
        download = appendToHomeDir "downloads";
        music = appendToHomeDir "music";
        pictures = appendToHomeDir "pictures";
        publicShare = appendToHomeDir "public";
        templates = appendToHomeDir "templates";
        videos = appendToHomeDir "videos";
      };
  };
}
