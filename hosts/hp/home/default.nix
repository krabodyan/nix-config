{
  module = {
    # ------------- cli
    home-manager.enable = true;
    nix-index.enable = true;
    nh.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
    ripgrep.enable = true;
    tmux.enable = true;
    htop.enable = true;
    bat.enable = true;
    helix.enable = true;
    eza.enable = true;
    jq.enable = true;

    git = {
      enable = true;
      userName = "krabodyan";
      userEmail = "krabodyan@gmail.com";
    };
    git-delta.enable = true;
    lazygit.enable = true;
    gh.enable = true;
    kubectl.enable = true;

    cli-default = {
      enable = true;
    };
    fish = {
      enable = true;
      kube-prompt = false;
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
    screenshot.enable = true;
    firefox.enable = true;
    foot.enable = true;

    # ------------- desktop environment
    xdg.enable = true;
    variables.enable = true;
    qtct.enable = true;
    gtk.enable = true;
    wm-scripts = {
      enable = true;
      touchpad.type = "sway";
    };

    sway = {
      enable = true;
      background = "~/flake/assets/background.jpg";
    };

    rofi.enable = true;
    swaylock.enable = true;
    mako.enable = true;
    wm-utils.enable = true;
    cliphist.enable = true;
  };
}
