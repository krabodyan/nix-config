{
  pkgs,
  yes,
  ...
}: {
  module = {
    agenix.enable = true;

    # ------------- cli
    bat = yes;
    clang-format = yes;
    eza = yes;
    fastfetch = yes;
    fzf = yes;
    helix = yes;
    home-manager = yes;
    htop = yes;
    jq = yes;
    network-utils = yes;
    nh = yes;
    nix-index = yes;
    postgres-cli = yes;
    python = yes;
    ripgrep = yes;
    rustfmt = yes;
    tmux = yes;
    yazi = yes;
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

    cli-default = {
      enable = true;
      extra = with pkgs; [
        postman
        # vagrant
        # tenv
        # ansible
        # cdrtools
        lazydocker

        # scrcpy
        # android-tools

        litecli

        imagemagick
        ffmpeg-full
      ];
    };

    fish = {
      enable = true;
      kube-prompt = false;
      ssh-prompt = false;
      loginShell = {
        enable = true;
        withIGPU = true;
        wm = "sway";
      };
    };

    # ------------- gui
    gui-default = {
      enable = true;
      extra = with pkgs; [
        gcolor3
        gimp
        system-config-printer
        onlyoffice-bin
        qbittorrent
        solaar
        obsidian
        whatsie
      ];
    };

    discord = yes;
    firefox = yes;
    foot = yes;
    mpv = yes;
    obs = yes;
    screenshot = yes;
    swayimg = yes;
    telegram = yes;
    zathura = yes;
    zoom = yes;

    # ------------- desktop environment
    gtk = yes;
    qtct = yes;
    variables = yes;
    xdg = yes;

    # ------------- window manager
    wm-utils = yes;
    wm-scripts = {
      enable = true;
      touchpad.type = "sway";
    };
    mako = yes;
    rofi = yes;
    swaylock = yes;

    sway = {
      enable = true;
      background = "~/flake/assets/background.jpg";
      menu = "rofi";
    };
  };
}
