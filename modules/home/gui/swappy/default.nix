{
  lib,
  pkgs,
  fonts,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.swappy;
in {
  options = {
    module.swappy = {
      enable = mkEnableOption "swappy tool (swappy)";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.swappy];
    # TODO
    # custom_color
    xdg.configFile."swappy/config".text =
      # ini
      ''
        [Default]
        early_exit=true
        auto_save=false
        save_dir=/home/$USER/pictures
        save_filename_format=swappy-%Y-%m-%d-%H-%M-%S.png
        line_size=3
        text_size=20
        text_font=${fonts.monospace}
        show_panel=true
        paint_mode=Arrow
        fill_shape=false
      '';
  };
}
