{
  yes,
  pkgs,
  ...
}: {
  module = {
    agenix = yes;

    # ------------- cli
    bat = yes;
    eza = yes;
    fastfetch = yes;
    fzf = yes;
    postgres-cli = yes;
    home-manager = yes;
    htop = yes;
    jq = yes;
    network-utils = yes;
    nh = yes;
    nix-index = yes;
    python = yes;
    ripgrep = yes;
    tmux = yes;
    yazi = yes;
    zoxide = yes;
    ssh = yes;
    obs = yes;

    git = {
      enable = true;
      gh = yes;
      delta = yes;
      userName = "krabodyan";
      userEmail = "krabodyan@gmail.com";
    };

    helix = {
      enable = true;
      components = ["base" "sql" "cpp" "web"];
    };

    cli-default = {
      enable = true;
      dev = true;
      extra = with pkgs; [
        appimage-run
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
        wm = "sway";
      };
    };

    # ------------- gui
    gui-default = {
      enable = true;
      extra = with pkgs; [
        chromium
        onlyoffice-desktopeditors
        mission-planner
        qgroundcontrol
        betaflight-configurator
      ];
    };

    firefox = yes;
    foot = yes;
    mpv = yes;
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
      background = "~/flake/assets/background.jpg";
      menu = "rofi";
      screenshot = "swappy";
    };
  };
}
