{yes, ...}: {
  module = {
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
    kubectl = yes;
    lazygit = yes;

    cli-default = yes;

    fish = {
      enable = true;
      kube-prompt = true;
      ssh-prompt = true;
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
    screenshot = yes;
    firefox = yes;
    foot = yes;

    # ------------- desktop environment
    gtk = yes;
    qtct = yes;
    variables = yes;
    xdg = yes;
    wm-scripts = {
      enable = true;
      touchpad.type = "sway";
    };

    sway = {
      enable = true;
      background = "~/flake/assets/background.jpg";
    };

    mako = yes;
    rofi = yes;
    swaylock = yes;
    wm-utils = yes;
  };
}
