{pkgs, ...}: {
  module = {
    home-manager.enable = true;
    nh.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
    cli-default = {
      enable = true;
      extra = with pkgs; [scrcpy android-tools];
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
