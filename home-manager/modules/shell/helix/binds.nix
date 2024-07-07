let
  binds = {
    "C-x" = ":q";
    "C-s" = ":w";
    "C-c" = "normal_mode";
    "C-7" = "toggle_comments";
    "C-/" = "toggle_comments";
    "A-x" = "extend_line_up";
    "S-x" = [
      "extend_line_up"
      "extend_to_line_bounds"
    ];
    "C-A-up" = [
      "extend_to_line_bounds"
      "extend_line_below"
      "split_selection_on_newline"
      "rotate_selection_contents_forward"
      "rotate_selections_backward"
      "keep_primary_selection"
    ];
    "C-A-down" = [
      "extend_to_line_bounds"
      "extend_line_above"
      "split_selection_on_newline"
      "rotate_selection_contents_forward"
      "keep_primary_selection"
    ];
    "C-S-up" = [
      "extend_line"
      "yank"
      "open_above"
      "normal_mode"
      "replace_with_yanked"
      "insert_mode"
    ];
    "C-S-down" = [
      "extend_line"
      "yank"
      "move_line_down"
      "open_above"
      "normal_mode"
      "replace_with_yanked"
      "insert_mode"
    ];
  };
in
{
  normal = binds // {
    p = "paste_clipboard_after";
    P = "paste_clipboard_before";
    y = "yank_main_selection_to_clipboard";
    "A-tab" = ":buffer-next";
    "S-q" = ":buffer-close";
    esc = [
      "collapse_selection"
      "keep_primary_selection"
    ];
  };
  insert = binds;
  select = binds;
}
