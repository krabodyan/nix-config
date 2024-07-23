let
  binds = {
    "C-x" = ":q";
    "C-s" = [
      ":w"
      "normal_mode"
      "commit_undo_checkpoint"
    ];
    "C-c" = [
      "normal_mode"
      "commit_undo_checkpoint"
    ];
    "C-7" = "toggle_comments";
    "C-/" = "toggle_comments";
    "C-A-up" = [
      "goto_line_end"
      "extend_line_below"
      "delete_selection"
      "move_line_up"
      "paste_before"
    ];
    "C-A-down" = [
      "goto_line_end"
      "extend_line_below"
      "delete_selection"
      "paste_after"
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
  special = {
    tab = ":buffer-next";
    "A-x" = "extend_line_up";
    "S-x" = [
      "extend_line_up"
      "extend_to_line_bounds"
    ];
    "S-q" = ":buffer-close";
    esc = [
      "collapse_selection"
      "keep_primary_selection"
    ];
    f = "file_picker_in_current_buffer_directory";
    p = "paste_clipboard_after";
    P = "paste_clipboard_before";
    y = "yank_main_selection_to_clipboard";
  };
in
{
  normal = binds // special;
  insert = binds // {
    ret = [
      "insert_newline"
      "commit_undo_checkpoint"
    ];
    "A-h" = "move_char_left";
    "A-l" = "move_char_right";
    "A-j" = "move_line_down";
    "A-k" = "move_line_up";
  };
  select = binds // special;
}
