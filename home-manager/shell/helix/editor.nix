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
  completion-trigger-len = 3;

  undercurl = false;
  bufferline = "multiple";
  popup-border = "none";
  text-width = 90;
  indent-heuristic = "tree-sitter";

  inline-diagnostics = {
    cursor-line = "hint";
    other-lines = "warning";
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
