let
  binds = {
    "A-space" = "buffer_picker";
    "A-e" = ":buffer-next";
    "C-A-p" = ":lsp-stop";
    "C-x" = ":q";
    "C-s" =
      [ ":w" "normal_mode" "collapse_selection" "commit_undo_checkpoint" ];
    "C-7" = "toggle_comments";
    "C-/" = "toggle_comments";
    "C-A-up" = [
      "goto_line_end"
      "extend_line_below"
      "delete_selection"
      "move_line_up"
      "paste_before"
    ];
    "C-A-down" =
      [ "goto_line_end" "extend_line_below" "delete_selection" "paste_after" ];
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
    "A-f" = [ "goto_line_end" "move_char_right" ];
    "A-+" = "increment";
    "A-minus" = "decrement";
  };
  special = {
    "a" = [
      "goto_line_start"
      # "move_char_right"
    ];
    "A-S-f" = "file_picker_in_current_buffer_directory";
    "A-x" = "extend_line_up";
    "S-x" = [ "extend_line_up" "extend_to_line_bounds" ];
    "S-q" = ":buffer-close";
    esc = [ "collapse_selection" "keep_primary_selection" ];
    # "p" = "paste_after";
    # "P" = "paste_before";
    # "S-p" = "paste_clipboard_before";
    # "S-P" = "paste_clipboard_after";
    "S-y" = "yank_main_selection_to_clipboard";
  };
in {
  normal = binds // special // { "C-c" = [ "insert_mode" ]; };
  insert = binds // {
    "C-c" = [ "normal_mode" ];
    "A-a" = [
      "goto_line_start"
      # "move_char_right"
    ];
    ret = [ "insert_newline" "commit_undo_checkpoint" ];
    "A-o" = "open_below";
    "A-O" = "open_above";
    "A-h" = "move_char_left";
    "A-l" = "move_char_right";
    "A-j" = "move_line_down";
    "A-k" = "move_line_up";
  };
  select = binds // special // {
    "C-c" = [ "collapse_selection" "normal_mode" ];
    "i" = [ "collapse_selection" "insert_mode" ];
  };
}
