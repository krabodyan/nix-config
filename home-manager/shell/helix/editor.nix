{
  insert-final-newline = true;
  mouse = false;
  # line-number = "relative";
  cursorline = true;
  color-modes = true;
  scrolloff = 10;

  completion-replace = false;
  preview-completion-insert = true;
  completion-timeout = 5;
  completion-trigger-len = 2;

  undercurl = false;
  # bufferline = "multiple";
  popup-border = "none";
  text-width = 140;
  indent-heuristic = "tree-sitter";

  inline-diagnostics = {
    cursor-line = "hint";
    other-lines = "error";
  };

  lsp = {
    display-messages = true;
    display-inlay-hints = true;
    snippets = false;
  };

  indent-guides = {
    render = true;
    # character = "╎";
    skip-levels = 2;
  };

  true-color = false;

  cursor-shape = {
    normal = "block";
    insert = "bar";
    select = "block";
  };

  soft-wrap = {
    enable = true;
    wrap-at-text-width = true;
  };

  gutters = { layout = [ "diff" "diagnostics" "line-numbers" "spacer" ]; };
  smart-tab = {
    enable = true;
    # supersede-menu = true;
  };
  statusline = {
    right = [
      # "version-control"
      "spinner"
    ];
    center = [ ];
    left = [
      "mode"
      "file-base-name"
      # "separator"
      "diagnostics"
      "read-only-indicator"
      "file-modification-indicator"
    ];
    separator = " ";
    mode = {
      normal = "normal";
      insert = "insert";
      select = "select";
    };
  };
}
