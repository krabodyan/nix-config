{
  yes,
  self,
  pkgs,
  ...
}: {
  module = {
    agenix = yes;

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
    lazygit = yes;
    network-utils = yes;
    nh = yes;
    nix-index = yes;
    python = yes;
    ripgrep = yes;
    rust-cli = yes;
    tmux = yes;
    yazi = yes;
    zoxide = yes;

    git = {
      enable = true;
      gh = yes;
      delta = yes;
      userName = "krabodyan";
      userEmail = "krabodyan@gmail.com";
    };

    cli-default = {
      enable = true;
      dev = true;
      extra = with pkgs; [
        # scrcpy
        # android-tools
        imagemagick
        ffmpeg-full
      ];
    };

    fish = {
      enable = true;
      prompt = {
        ssh = false;
        kubectl = false;
      };
      aliases = {
        git = true;
        podman = true;
        docker = false;
        kubectl = false;
      };
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
        system-config-printer
        onlyoffice-bin
        qbittorrent
        solaar
        mission-planner
        qgroundcontrol
        betaflight-configurator
        obsidian
      ];
    };

    discord = yes;
    firefox = yes;
    foot = yes;
    mpv = yes;
    obs = yes;
    swayimg = yes;
    telegram = yes;
    zathura = yes;

    # ------------- desktop environment
    gtk = yes;
    qtct = yes;
    variables = yes;
    xdg = yes;

    # ------------- window manager
    wm-utils = yes;
    wm-scripts = yes;
    mako = yes;
    rofi = yes;
    swaylock = yes;
    swappy = yes;

    sway = {
      enable = true;
      background = "${self}/assets/background.jpg";
      menu = "rofi";
    };
  };
}
