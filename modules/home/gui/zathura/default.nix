{
  lib,
  pkgs,
  fonts,
  colors,
  config,
  mkAssociations,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.zathura;
in {
  options = {
    module.zathura = {
      enable = mkEnableOption "zathura";
    };
  };
  config = mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = mkAssociations {
      types = [
        "application/pdf"
      ];
      desktop = "org.pwmt.zathura-pdf-mupdf.desktop";
    };

    programs.zathura = {
      enable = true;
      package = pkgs.zathura.override {
        useMupdf = true;
        plugins = [pkgs.zathuraPkgs.zathura_pdf_mupdf];
      };
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
        selection-clipboard = "clipboard";
        selection-notification = false;
      };
      mappings = {
        "f" = "toggle_fullscreen";
        "]" = "rotate";
        "g" = "goto";
        "m" = "focus_inputbar ':blist '";
        "M" = "focus_inputbar ':bjump '";
        "<A-m>" = "focus_inputbar ':bmark '";
      };
    };
  };
}
