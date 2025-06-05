{
  yes,
  self,
  ...
}: {
  module = {
    agenix.enable = true;

    # ------------- cli
    bat = yes;
    eza = yes;
    fzf = yes;
    helix = yes;
    home-manager = yes;
    htop = yes;
    jq = yes;
    nh = yes;
    nix-index = yes;
    ripgrep = yes;
    tmux = yes;
    zoxide = yes;

    git = {
      enable = true;
      userName = "krabodyan";
      userEmail = "krabodyan@gmail.com";
    };
    gh = yes;
    git-delta = yes;

    cli-default = yes;

    fish = {
      enable = true;
      prompt = {
        ssh = true;
        kubectl = false;
      };
      aliases = {
        git = true;
        podman = false;
        docker = true;
        kubectl = false;
      };
      loginShell = {
        enable = true;
        withIGPU = false;
        wm = "sway";
      };
    };

    # ------------- gui
    gui-default = {
      enable = true;
    };
    firefox = yes;
    foot = yes;

    # ------------- desktop environment
    gtk = yes;
    qtct = yes;
    variables = yes;
    xdg = yes;

    # ------------- window manager
    wm-scripts = yes;

    sway = {
      enable = true;
      background = "${self}/assets/background.jpg";
      menu = "rofi";
    };

    mako = yes;
    rofi = yes;
    wm-utils = yes;
  };
}
