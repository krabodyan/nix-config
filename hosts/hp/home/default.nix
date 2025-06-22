{yes, ...}: {
  module = {
    agenix.enable = true;

    # ------------- cli
    bat = yes;
    eza = yes;
    fzf = yes;
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
      gh = yes;
      delta = yes;
      userName = "krabodyan";
      userEmail = "krabodyan@gmail.com";
    };

    helix = {
      enable = true;
      components = ["base"];
    };

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
    gui-default = yes;
    firefox = yes;
    foot = yes;

    # ------------- desktop environment
    gtk = yes;
    qtct = yes;
    variables = yes;
    xdg = yes;

    # ------------- window manager
    wm-scripts = yes;
    mako = yes;
    rofi = yes;
    wm-utils = yes;
    swappy = yes;

    sway = {
      enable = true;
      background = "~/flake/assets/background.jpg";
      menu = "rofi";
    };
  };
}
