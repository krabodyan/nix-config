{pkgs, ...}: {
  module = {
    # ------------- cli
    home-manager.enable = true;
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
    git = {
      enable = true;
      userName = "krabodyan";
      userEmail = "krabraketa@gmail.com";
    };
    cli-default = {
      enable = true;
      extra = with pkgs; [
        scrcpy
        android-tools
        arduino-cli
        platformio
        pkgs.pkgsCross.avr.buildPackages.gcc
      ];
    };
    fish = {
      enable = true;
      loginShell = {
        enable = true;
        wm = "river";
        withIGPU = true;
      };
    };

    # ------------- gui
    gui-default = {
      enable = true;
      extra = with pkgs; [
        gimp
        system-config-printer
        fritzing
        whatsie
        onlyoffice-bin
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
    de-scripts = {
      enable = true;
      touchpadcommands = {
        toggleup = ''
          riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events enabled
        '';
        toggledown = ''
          riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" events disabled
        '';
      };
    };
    river = {
      enable = true;
      background = "~/flake/assets/background.jpg";
    };
    rofi.enable = true;
    swaylock.enable = true;
    mako.enable = true;
    de-packages.enable = true;
  };
}
