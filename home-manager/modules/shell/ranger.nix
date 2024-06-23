{ config, pkgs, ... }: {
  xdg.configFile."ranger/rc.conf".text = ''
    set preview_images false
    #set preview_images_method sixel
    #set sixel_dithering Riemersma

    set wrap_plaintext_previews false
    # set colorscheme jungle
    set draw_borders both
    set column_ratios 1,1
    set mouse_enabled false
    set show_selection_in_titlebar false
    set one_indexed true
    set line_numbers absolute
    set dirname_in_tabs true
    set display_size_in_status_bar false
    set confirm_on_delete always
    set binary_size_prefix true
    set sort_directories_first true
    set padding_right false
  '';
}

