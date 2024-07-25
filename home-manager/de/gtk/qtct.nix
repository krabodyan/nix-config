{ pkgs, ... }:
{
  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    color_scheme_path=${pkgs.qt5ct}/share/qt5ct/colors/airy.conf
    custom_palette=false
    icon_theme=Papirus-Dark
    standard_dialogs=gtk2
    style=kvantum-dark

    [Fonts]
    fixed="IosevkaTerm Nerd Font,10,-1,5,57,0,0,0,0,0,Medium"
    general="Roboto Medium,12,-1,5,50,0,0,0,0,0"

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [SettingsWindow]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\ae\0\0\x4\x37\0\0\0\0\0\0\0\0\0\0\x2\xde\0\0\x2\x44\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\ae\0\0\x4\x37)

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid() 
  '';
  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${pkgs.qt6ct}/share/qt6ct/colors/airy.conf
    custom_palette=false
    icon_theme=Papirus-Dark
    standard_dialogs=gtk2
    style=kvantum-dark

    [Fonts]
    fixed="IosevkaTerm Nerd Font,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1"
    general="Roboto Medium,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [SettingsWindow]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x3\xa4\0\0\x4%\0\0\0\0\0\0\0\0\0\0\x3\xa4\0\0\x4%\0\0\0\0\0\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x3\xa4\0\0\x4%)

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid() 
  '';
}
