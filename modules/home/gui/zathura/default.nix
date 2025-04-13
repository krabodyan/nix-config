{
  lib,
  fonts,
  colors,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.zathura;
in {
  options = {
    module.zathura = {
      enable = mkEnableOption "enable zathura";
    };
  };
  config = mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
    };

    programs.zathura = {
      enable = true;
      options = with colors.hex; {
        adjust-open = "best-fit";
        default-bg = bg;
        default-fg = fg;
        statusbar-bg = bg;
        statusbar-fg = fg;
        inputbar-bg = surface0;
        inputbar-fg = fg;
        notification-error-bg = red;
        notification-error-fg = bg;
        notification-warning-bg = yellow;
        notification-warning-fg = bg;
        highlight-color = "rgba(239, 137, 147, 0.7)";
        highlight-active-color = "rgba(245, 194, 231, 0.7)";
        completion-highlight-fg = bg;
        completion-highlight-bg = select;
        completion-bg = surface0;
        completion-fg = fg;
        n-completion-items = 7;
        completion-group-bg = surface1;
        notification-bg = surface0;
        notification-fg = fg;
        index-active-bg = select;
        index-active-fg = bg;
        index-fg = fg;
        index-bg = bg;
        font = "${fonts.monospace} 16";
      };
      mappings = {
        "f" = "toggle_fullscreen";
        "]" = "rotate";
        "g" = "goto";
        "m" = "focus_inputbar ':blist '";
        "M" = "focus_inputbar ':bmark '";
      };
    };
  };
}
