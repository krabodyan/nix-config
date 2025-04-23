{pkgs, ...}: {
  module = {
    # ------------- cli
    home-manager.enable = true;
    nix-index.enable = true;
    nh.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
    ripgrep.enable = true;
    fastfetch.enable = true;
    tmux.enable = true;
    htop.enable = true;
    rustfmt.enable = true;
    yazi.enable = true;
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

    cli-default = {
      enable = true;
      extra = with pkgs; [
        sqlx-cli
        scrcpy
        android-tools
        postgresql
        litecli
        lazydocker
      ];
    };
    fish = {
      enable = true;
      loginShell = {
        enable = true;
        wm = "sway";
        withIGPU = true;
      };
    };

    # ------------- gui
    gui-default = {
      enable = true;
      extra = with pkgs; [
        obsidian
        gimp
        system-config-printer
        fritzing
        whatsie
        onlyoffice-bin
        obs-studio
        qbittorrent
        solaar
        gcolor3
      ];
    };
    screenshot.enable = true;
    telegram.enable = true;
    discord.enable = true;
    zoom.enable = true;
    swayimg.enable = true;
    zathura.enable = true;
    mpv.enable = true;
    firefox.enable = true;
    foot.enable = true;

    # ------------- desktop environment
    xdg.enable = true;
    variables.enable = true;
    qtct.enable = true;
    gtk.enable = true;
    wm-scripts = {
      enable = true;
      touchpad-cmd =
        # bash
        ''
          swaymsg input type:touchpad events toggle enabled disabled
        '';
        # ''
        #   if riverctl list-input-configs | grep -q "disabled"; then
        #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events enabled
        #   else
        #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events disabled
        #   fi
        # '';
    };
    sway = {
      enable = true;
      background = "~/flake/assets/background.jpg";
    };
    # river = {
    #   enable = true;
    #   background = "~/flake/assets/background.jpg";
    #   extraConfig = ''
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events disabled
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" scroll-factor 0.2
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" pointer-accel 0.3
    #     riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" accel-profile flat
    #     riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" accel-profile flat
    #     riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" pointer-accel 0
    #   '';
    # };

    rofi.enable = true;
    swaylock.enable = true;
    mako.enable = true;
    wm-utils.enable = true;
  };
}
