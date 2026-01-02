{
  yes,
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
    ssh = yes;
    tmux = yes;
    yazi = yes;
    zoxide = yes;
    meld = yes;
    less = yes;
    gcc = yes;
    sc-im = yes;
    postgres-cli = yes;

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
        perf
        openvpn
        imagemagick
        ffmpeg-full
      ];
    };

    helix = {
      enable = true;
      components = ["base" "cpp" "web"];
    };

    fish = {
      enable = true;
      prompt = {
        ssh = false;
        kubectl = false;
      };
      aliases = {
        git = true;
        cmake = true;
        docker = true;
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
        anydesk
        remmina
        gcolor3
        google-chrome
        # betaflight-configurator
        system-config-printer
        onlyoffice-desktopeditors
        qbittorrent
        solaar
      ];
    };

    discord = yes;
    firefox = yes;
    foot = yes;
    mpv = yes;
    obs = yes;
    swayimg = yes;
    telegram = yes;
    viber = yes;
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
      background = "~/flake/assets/background.jpg";
      menu = "rofi";
      screenshot = "swappy";
    };
  };
}
