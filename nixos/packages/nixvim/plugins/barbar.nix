{
  enable = true;
  settings = {
    auto_hide = 1;
    focus_on_close = "previous";
    insert_at_start = true;
    animation = false;
    icons = {
      button = false;
      inactive.separator.left = "";
      inactive.separator.right = " ";
      pinned.separator.right = "";
      preset = "slanted";
    };
  };
  keymaps = {
    next.key = "<TAB>";
    previous.key = "<S-TAB>";
    close.key = "<S-q>";
  };
}