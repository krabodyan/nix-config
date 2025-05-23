{
  pkgs,
  yes,
  ...
}: {
  module = {
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
      kube-prompt = true;
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

    # river = {
    #   extraConfig = ''
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events disabled
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" tap enabled
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" dwt enabled
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" natural_scroll enabled
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" scroll-factor 0.2
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" pointer-accel 0.3
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" accel-profile flat
    #     riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" accel-profile flat
    #     riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" pointer-accel 0
    #   '';
    # };
  };
}
