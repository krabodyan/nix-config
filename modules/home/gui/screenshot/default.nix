{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.screenshot;
in {
  options = {
    module.screenshot = {
      enable = mkEnableOption "enable screenshot (swappy)";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.swappy];
    xdg.configFile."swappy/config".text = ''
      [Default]
      save_dir=/home/$USER/pictures
      save_filename_format=swappy-%Y-%m-%d-%H-%M-%S.png
      show_panel=true
      line_size=3
      text_size=20
      text_font=RobotoMedium
      paint_mode=Arrow
      early_exit=true
      fill_shape=false
    '';
  };
}
