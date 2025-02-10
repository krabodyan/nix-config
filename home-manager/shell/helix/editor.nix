{
  insert-final-newline = true;
  mouse = false;
  # line-number = "relative";
  cursorline = true;
  color-modes = true;
  scrolloff = 10;
  scroll-lines = 1;

  continue-comments = false;

  completion-replace = false;
  preview-completion-insert = true;
  completion-timeout = 5;
  completion-trigger-len = 2;

  undercurl = false;
  bufferline = "multiple";
  popup-border = "all";
  text-width = 145;
  indent-heuristic = "tree-sitter";
  jump-label-alphabet = "fjdkshlweruiopmaqcvngbzxty";

  end-of-line-diagnostics = "warning";
  inline-diagnostics = {
    cursor-line = "warning";
    other-lines = "error";
  };

  lsp = {
    enable = true;
    display-messages = true;
    display-progress-messages = false;
    display-inlay-hints = true;
    display-signature-help-docs = false;
    snippets = true;
    auto-signature-help = false;
  };

  indent-guides = {
    render = true;
    # character = "╎";
    skip-levels = 1;
  };

  true-color = false;

  cursor-shape = {
    normal = "block";
    insert = "block"; # bar
    select = "block";
  };

  soft-wrap = {
    enable = true;
    wrap-at-text-width = true;
  };

  gutters = { layout = [ "diff" "diagnostics" "line-numbers" "spacer" ]; };
  smart-tab = {
    enable = false;
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
