{
  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin";
      style = "numbers,grid,changes";
    };
  };
  xdg.configFile."bat/themes/catppuccin.tmTheme".source = ./theme.tmTheme;
}
