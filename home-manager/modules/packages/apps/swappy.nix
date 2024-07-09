{ pkgs, ... }:
{
  home.packages = [ pkgs.swappy ];
  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=/home/$USER/pictures
    save_filename_format=swappy-%Y-%m-%d-%H-%M-%S.png
    show_panel=true
    line_size=5
    text_size=20
    text_font=RobotoMedium
    paint_mode=Arrow
    early_exit=true
    fill_shape=false
  '';
}
