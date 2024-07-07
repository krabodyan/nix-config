{ config, helpers, ... }:
{
  programs.zathura = {
    enable = true;
    options =
      with config.colors;
      with helpers;
      {
        database = "sqlite";
        selection-clipboard = "clipboard";
        font = "${config.font} 14";
        # recolor-keephue = true;
        recolor = true;
        # render-loading = false;
        incremental-search = true;

        default-bg = mkHex bg;
        default-fg = mkHex fg;
        statusbar-bg = mkHex bg;
        statusbar-fg = mkHex fg;
        inputbar-bg = mkHex bg;
        inputbar-fg = mkHex fg;
        highlight-color = accent-rgba;
        highlight-active-color = accent-rgba;
        recolor-darkcolor = mkHex fg;
        recolor-lightcolor = mkHex bg;
        notification-warning-bg = mkHex pink;
        notification-error-bg = mkHex red;
        notification-bg = mkHex bg;
        notification-fg = mkHex lightgreen;
      };
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };
}
