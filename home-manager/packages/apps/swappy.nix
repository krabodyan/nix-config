{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.swappy
    pkgs.satty
  ];
  xdg.configFile."satty/config.toml".text = with config.colors; ''
    [general]
    # Start Satty in fullscreen mode
    fullscreen = true
    # Exit directly after copy/save action
    early-exit = true
    # Select the tool on startup [possible values: pointer, crop, line, arrow, rectangle, text, marker, blur, brush]
    initial-tool = "arrow"
    # Configure the command to be called on copy, for example `wl-copy`
    copy-command = "wl-copy"
    # Increase or decrease the size of the annotations
    annotation-size-factor = 2
    # Filename to use for saving action. Omit to disable saving to file. Might contain format specifiers: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
    output-filename = "/tmp/scr-%Y-%m-%d_%H:%M:%S.png"
    # After copying the screenshot, save it to a file as well
    save-after-copy = false
    # Hide toolbars by default
    default-hide-toolbars = false
    # The primary highlighter to use, the other is accessible by holding CTRL at the start of a highlight [possible values: block, freehand]
    primary-highlighter = "block"
    disable-notifications = false

    # Font to use for text annotations
    [font]
    family = "Roboto"
    style = "Bold"

    # custom colours for the colour palette
    [color-palette]
    first= "#${red}"
    second= "#${yellow}"
    third= "#${bg}"
    fourth= "#${blue}"
    fifth= "#${fg-bright}"
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
