{
  mouse = false;
  clipboard-provider = "wayland";
  undercurl = true;
  default-line-ending = "lf";

  auto-format = false;
  continue-comments = false;
  insert-final-newline = true;
  trim-trailing-whitespace = true;

  cursorline = true;
  scrolloff = 12;
  scroll-lines = 1;

  completion-replace = false;
  completion-timeout = 5;
  completion-trigger-len = 2;
  preview-completion-insert = true;

  bufferline = "multiple";
  popup-border = "all";
  text-width = 145;
  jump-label-alphabet = "jklfdsahgiorewmcnvb";
  smart-tab.enable = false;

  end-of-line-diagnostics = "disable";
  inline-diagnostics = {
    cursor-line = "hint";
    other-lines = "disable";
    max-diagnostics = 3;
  };

  lsp = {
    enable = true;
    snippets = true;
    display-messages = true;
    display-inlay-hints = false;
    auto-signature-help = false;
    inlay-hints-length-limit = 24;
    display-progress-messages = true;
    display-signature-help-docs = false;
  };

  indent-guides = {
    render = true;
    character = "▏";
    skip-levels = 1;
  };

  cursor-shape = {
    normal = "block";
    insert = "bar";
    select = "block";
  };

  soft-wrap = {
    enable = true;
    wrap-at-text-width = true;
  };

  file-picker.hidden = false;

  gutters.layout = ["diff" "diagnostics" "line-numbers" "spacer"];

  statusline = {
    separator = " ";

    diagnostics = [
      "hint"
      "warning"
      "error"
    ];

    workspace-diagnostics = [
      "hint"
      "warning"
      "error"
    ];

    right = [
      "read-only-indicator"
      "file-modification-indicator"
      "separator"
      "file-name"
      "spinner"
    ];

    center = [
      "diagnostics"
      "workspace-diagnostics"
    ];

    left = [];
  };
}
