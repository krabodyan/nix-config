{ theme, helpers, ... }: {
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };

  programs.zathura = {
    enable = true;
    options = with theme;
      let inherit (helpers) mkHex;
      in {
        adjust-open = "best-fit";
        default-bg = mkHex bg;
        default-fg = mkHex fg;
        statusbar-bg = mkHex bg;
        statusbar-fg = mkHex fg;
        inputbar-bg = mkHex surface0;
        inputbar-fg = mkHex fg;
        notification-error-bg = mkHex red;
        notification-error-fg = mkHex bg;
        notification-warning-bg = mkHex yellow;
        notification-warning-fg = mkHex bg;
        highlight-color = "rgba(239, 137, 147, 0.7)";
        highlight-active-color = "rgba(245, 194, 231, 0.7)";
        completion-highlight-fg = mkHex bg;
        completion-highlight-bg = mkHex select;
        completion-bg = mkHex surface0;
        completion-fg = mkHex fg;
        n-completion-items = 7;
        completion-group-bg = mkHex surface1;
        notification-bg = mkHex surface0;
        notification-fg = mkHex fg;
        index-active-bg = mkHex select;
        index-active-fg = mkHex bg;
        index-fg = mkHex fg;
        index-bg = mkHex bg;
        font = "${font} 16";
      };
    mappings = {
      "f" = "toggle_fullscreen";
      "]" = "rotate";
      "g" = "goto";
      "m" = "focus_inputbar ':blist '";
      "M" = "focus_inputbar ':bmark '";
    };
  };
}
