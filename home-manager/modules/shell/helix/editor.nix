{
  insert-final-newline = true;
  mouse = false;
  line-number = "relative";
  cursorline = true;
  color-modes = true;
  scrolloff = 10;

  completion-replace = false;
  preview-completion-insert = true;
  completion-timeout = 5;
  completion-trigger-len = 1;

  undercurl = false;
  bufferline = "multiple";
  popup-border = "none";
  text-width = 110;
  indent-heuristic = "tree-sitter";

  lsp = {
    display-messages = true;
    display-inlay-hints = true;
    snippets = true;
  };

  indent-guides = {
    render = true;
    character = "╎";
    skip-levels = 2;
  };

  true-color = false;

  cursor-shape = {
    normal = "block";
    insert = "bar";
    select = "underline";
  };

  soft-wrap = {
    enable = true;
    wrap-at-text-width = true;
  };

  statusline = {
    right = [
      "version-control"
      "spinner"
    ];
    center = [ "diagnostics" ];
    left = [
      "mode"
      "file-base-name"
      "file-modification-indicator"
      "read-only-indicator"
    ];
    separator = " │ ";
    mode = {
      normal = "normal";
      insert = "insert";
      select = "select";
    };
  };
}
