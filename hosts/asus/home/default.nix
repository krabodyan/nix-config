{pkgs, ...}: {
  module = {
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
  };
}
