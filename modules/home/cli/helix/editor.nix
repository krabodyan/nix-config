{
  insert-final-newline = true;
  trim-trailing-whitespace = true;
  mouse = false;
  cursorline = true;
  color-modes = true;
  scrolloff = 12;
  scroll-lines = 1;
  auto-format = false;

  continue-comments = false;

  completion-replace = false;
  preview-completion-insert = true;
  completion-timeout = 5;
  completion-trigger-len = 2;

  undercurl = false;
  bufferline = "multiple";
  popup-border = "all";
  text-width = 145;
  jump-label-alphabet = "jklfdsahgiorewmcnvb";

  clipboard-provider = "wayland";

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
    display-inlay-hints = true;
    auto-signature-help = false;
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

  file-picker = {
    hidden = false;
  };

  gutters.layout = ["diff" "diagnostics" "line-numbers" "spacer"];
  smart-tab = {
    enable = false;
  };

  statusline = {
    diagnostics = ["hint" "warning" "error"];
    workspace-diagnostics = ["hint" "warning" "error"];
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
    separator = " ";
  };
}
