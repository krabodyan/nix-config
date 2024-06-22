{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    qt5ct
    qt6ct
  ];

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
[Appearance]
color_scheme_path=${pkgs.qt5ct}/share/qt5ct/colors/airy.conf
custom_palette=false
icon_theme=Papirus-Dark
standard_dialogs=gtk2
style=gtk2

[Fonts]
fixed="JetBrainsMono Nerd Font,10,-1,5,57,0,0,0,0,0,Medium"
general="Roboto,10,-1,5,57,0,0,0,0,0,Medium"

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
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x2\x9e\0\0\x2\xdb\0\0\0\0\0\0\0\0\0\0\x5U\0\0\x2\xff\0\0\0\0\x2\0\0\0\x5V\0\0\0\0\0\0\0\0\0\0\x2\x9e\0\0\x2\xdb)

[Troubleshooting]
force_raster_widgets=1
ignored_applications=@Invalid()
  '';
  xdg.configFile."qt6ct/qt6ct.conf".text = ''
[Appearance]
color_scheme_path=${pkgs.qt6ct}/share/qt6ct/colors/darker.conf
custom_palette=false
icon_theme=Papirus-Dark
standard_dialogs=gtk2
style=qt6gtk2

[Fonts]
fixed="JetBrainsMono Nerd Font,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium"
general="Roboto,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium"

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
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x5\x45\0\0\x2\xdb\0\0\0\0\0\0\0\0\0\0\x2\xaa\0\0\x2\xeb\0\0\0\0\x2\0\0\0\x5V\0\0\0\0\0\0\0\0\0\0\x5\x45\0\0\x2\xdb)

[Troubleshooting]
force_raster_widgets=1
ignored_applications=@Invalid()
  '';
}

