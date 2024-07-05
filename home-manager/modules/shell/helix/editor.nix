{
  insert-final-newline = false;
  mouse = false;
  line-number = "relative";
  cursorline = true;
  color-modes = true;
  scrolloff = 10;

  completion-replace = false;
  preview-completion-insert = false;
  completion-timeout = 5;
  undercurl = true;
  bufferline = "multiple";
  popup-border = "none";
  text-width = 110;
  indent-heuristic = "tree-sitter";

  lsp = {
    display-messages = true;
    display-inlay-hints = true;
    snippets = false;
  };

  indent-guides = {
    render = true;
    skip-levels = 1;
  };

  true-color = true;

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
    right = [ "version-control" "spinner" ];
    center = [ "diagnostics" ];
    left = [ "mode" "file-base-name" "file-modification-indicator" "read-only-indicator" ];
    separator = " │ ";
    mode = {
      normal = "normal";
      insert = "insert";
      select = "select";
    };
  };
}
