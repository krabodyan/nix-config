{
  insert-final-newline = true;
  trim-trailing-whitespace = true;
  mouse = false;
  cursorline = true;
  color-modes = true;
  scrolloff = 10;
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
  jump-label-alphabet = "fjdkshlweruiopmaqcvngbzxty";

  clipboard-provider = "wayland";

  end-of-line-diagnostics = "hint";
  inline-diagnostics = {
    cursor-line = "info";
    max-diagnostics = 3;
  };

  lsp = {
    enable = true;
    display-messages = true;
    display-progress-messages = false;
    display-inlay-hints = true;
    display-signature-help-docs = false;
    snippets = false;
    auto-signature-help = true;
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
    right = [
      "diagnostics"
      "read-only-indicator"
      "file-modification-indicator"
      "file-name"
      "spinner"
    ];
    center = [];
    left = [];
    separator = " ";
  };
}
