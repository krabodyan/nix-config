let
  binds = {
    "C-x" = ":q";
    "C-s" = ":w";
    "C-c" = "normal_mode";
    "C-7" = "toggle_comments";
    "C-/" = "toggle_comments";
    "C-A-down" = [
      "extend_to_line_bounds"
      "delete_selection"
      "paste_after"
    ];
    "C-A-up" = [
      "extend_to_line_bounds"
      "delete_selection"
      "move_line_up"
      "paste_before"
    ];
  };
in
{
  normal = binds // {
    p = "paste_clipboard_before";
    y = "yank_main_selection_to_clipboard";
    tab = ":buffer-next";
    "S-q" = ":buffer-close";
    esc = [ "collapse_selection" "keep_primary_selection" ];
  };
  insert = binds;
  select = binds;
}
