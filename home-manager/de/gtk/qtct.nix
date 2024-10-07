{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    kdePackages.qt6ct
    libsForQt5.qt5ct
  ];
  xdg.configFile =
    let
      colors = ''
        [ColorScheme]
        active_colors=#ffe6dede, #ff1c1c1c, #ff1c1c1c, #ff151515, #ff383838, #ffa3a3a3, #ffe6dede, #ffe6dede, #ffe6dede, #ff151515, #ff1c1c1c, #ff151515, #ff2e2e2e, #ffa3a3a3, #ff83d9a0, #ffcc7073, #ff151515, #ffe6dede, #0f0f0f, #e6dede, #80151515
        disabled_colors=#ff808080, #ff1c1c1c, #ff1c1c1c, #ff151515, #ff424242, #ff6e738d, #ff808080, #ffe6dede, #ff808080, #ff151515, #ff1c1c1c, #ff151515, #ff2e2e2e, #ff808080, #ff83d9a0, #ffcc7073, #ff151515, #ffe6dede, #ff0f0f0f, #ffe6dede, #80151515
        inactive_colors=#ffe6dede, #ff1c1c1c, #ff1c1c1c, #ff151515, #ff424242, #ff6e738d, #ffe6dede, #ffe6dede, #ffe6dede, #ff151515, #ff1c1c1c, #ff151515, #ff2e2e2e, #ffa3a3a3, #ff83d9a0, #ffcc7073, #ff151515, #ffe6dede, #ff0f0f0f, #ffe6dede, #80151515
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
