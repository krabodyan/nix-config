{
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
    eza.enable = true;
    jq.enable = true;
    git = {
      enable = true;
      userName = "krabodyan";
      userEmail = "krabraketa@gmail.com";
    };
    cli-default = {
      enable = true;
    };
    fish = {
      enable = true;
      loginShell = {
        enable = true;
        wm = "river";
      };
    };

    # ------------- gui
    gui-default = {
      enable = true;
    };
    screenshot.enable = true;
    telegram.enable = true;
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
      touchpadcommands = {
        toggleup = ''
          riverctl input "pointer-2-7-SynPS/2_Synaptics_TouchPad" events enabled
        '';
        toggledown = ''
          riverctl input "pointer-2-7-SynPS/2_Synaptics_TouchPad" events disabled
        '';
      };
    };
    river = {
      enable = true;
      background = "~/flake/assets/background.jpg";
      extraConfig = ''
        riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" scroll-factor 0.2
        riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" pointer-accel 0.3
        riverctl input "pointer-1267-12410-ELAN1203:00_04F3:307A_Touchpad" accel-profile flat
        riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" accel-profile flat
        riverctl input "pointer-1133-50504-Logitech_USB_Receiver_Mouse" pointer-accel 0
        riverctl map -layout 0 normal Super V       spawn "foot -w 850x800 -a floaterm clipse"
        pidof clipse || clipse -listen &
      '';
    };
    rofi.enable = true;
    swaylock.enable = true;
    mako.enable = true;
    wm-utils.enable = true;
    clipse.enable = true;
  };
}
