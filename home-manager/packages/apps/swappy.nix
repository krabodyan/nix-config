{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.swappy
    pkgs.satty
  ];
  xdg.configFile."satty/config.toml".text = with config.colors; ''
    [general]
    fullscreen = true
    early-exit = true
    initial-tool = "arrow"
    copy-command = "wl-copy"
    annotation-size-factor = 0.2
    output-filename = "/tmp/scr-%Y-%m-%d_%H:%M:%S.png"
    save-after-copy = false
    default-hide-toolbars = false
    primary-highlighter = "block"
    disable-notifications = true

    [font]
    family = "Roboto"
    style = "Bold"

    [color-palette]
    first= "#${red}"
    second= "#${yellow}"
    third= "#${fg}"
    fourth= "#${blue}"
    fifth= "#${pink}"
    custom= "#${green}"    
  '';
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
}
