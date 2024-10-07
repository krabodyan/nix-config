{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    kdePackages.qt6ct
    libsForQt5.qt5ct
  ];
  xdg.configFile =
    let
      colors = with config.colors; ''
        [ColorScheme]
        active_colors=#ff${fg}, #ff${bg-bright}, #ff${bg-bright}, #ff${bg}, #ff${surface2}, #ff${overlay2}, #ff${fg}, #ff${fg}, #ff${fg}, #ff${bg}, #ff${bg-bright}, #ff${bg}, #ff${surface0}, #ff${overlay2}, #ff${green}, #ff${red}, #ff${bg}, #ff${fg}, #${bg-dark}, #${fg}, #80${bg}
        disabled_colors=#ff${overlay1}, #ff${bg-bright}, #ff${bg-bright}, #ff${bg}, #ff${fg-dark}, #ff${overlay0}, #ff${overlay1}, #ff${fg}, #ff${overlay1}, #ff${bg}, #ff${bg-bright}, #ff${bg}, #ff${surface0}, #ff${overlay1}, #ff${green}, #ff${red}, #ff${bg}, #ff${fg}, #ff${bg-dark}, #ff${fg}, #80${bg}
        inactive_colors=#ff${fg}, #ff${bg-bright}, #ff${bg-bright}, #ff${bg}, #ff${fg-dark}, #ff${overlay0}, #ff${fg}, #ff${fg}, #ff${fg}, #ff${bg}, #ff${bg-bright}, #ff${bg}, #ff${surface0}, #ff${overlay2}, #ff${green}, #ff${red}, #ff${bg}, #ff${fg}, #ff${bg-dark}, #ff${fg}, #80${bg}
      '';
    in
    {
      "qt5ct/colors/paradise.conf".text = colors;
      "qt6ct/colors/paradise.conf".text = colors;
      "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        color_scheme_path=${config.xdg.configHome}/qt5ct/colors/paradise.conf
        custom_palette=true
        icon_theme=${config.gtk.iconTheme.name}
        standard_dialogs=default
        style=Fusion

        [Fonts]
        fixed="${config.font},12,-1,5,57,0,0,0,0,0,Medium"
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
      "qt6ct/qt6ct.conf".text = ''
        [Appearance]
        color_scheme_path=${config.xdg.configHome}/qt6ct/colors/paradise.conf
        custom_palette=true
        icon_theme=${config.gtk.iconTheme.name}
        standard_dialogs=default
        style=Fusion

        [Fonts]
        fixed="${config.font},12,-1,5,57,0,0,0,0,0,Medium"
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
    };
}
