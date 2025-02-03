let
  binds = {
    "C-f" = "file_picker_in_current_buffer_directory";
    "C-c" = "completion";
    "C-S-f" = ":sh foot -d error -a floaterm yazi";
    "C-space" = "buffer_picker";
    "A-s" = [ "normal_mode" "goto_word" ];
    "C-A-s" = [ "normal_mode" "extend_to_word" ];
    "A-a" = "split_selection_on_newline";
    "A-w" = "rotate_view";
    "A-space" = [
      ":new"
      ":insert-output __yazi_picker"
      "select_all"
      "split_selection_on_newline"
      "goto_file"
      "goto_last_modified_file"
      ":buffer-close!"
    ];

    "A-y" = "save_selection"; # save to jumplist
    "A-e" = ":buffer-next";
    "A-q" = ":buffer-previous";
    "C-q" = ":buffer-close";
    "C-A-p" = ":lsp-stop";
    "C-x" = ":q";
    "C-s" =
      [ ":w" "normal_mode" "collapse_selection" "commit_undo_checkpoint" ];

    "C-/" = "toggle_comments";
    "C-7" = "toggle_comments";
    "C-?" = "toggle_block_comments";

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
    "tab" = "no_op";
    "A-x" = "extend_line_up";
    "S-x" = [ "extend_line_up" "extend_to_line_bounds" ];
    "esc" = [ "collapse_selection" "keep_primary_selection" ];
    p = ":clipboard-paste-after";
    P = ":clipboard-paste-before";
    R = ":clipboard-paste-replace";
    y = ":clipboard-yank-join";
    Y = ":clipboard-yank";
  };
in {
  normal = binds // special // {
    "A-d" = [ "insert_mode" ];
    "A-l" = [ "move_next_word_end" "collapse_selection" "move_char_right" ];
    "A-h" = [ "move_prev_word_start" "collapse_selection" ];
  };
  insert = binds // {
    "A-d" = "normal_mode";
    "ret" = [ "insert_newline" "commit_undo_checkpoint" ];
    "A-o" = "open_below";
    "A-p" = "open_above";
    "A-h" = "move_char_left";
    "A-l" = "move_char_right";
    "A-j" = "move_line_down";
    "A-k" = "move_line_up";
  };
  select = binds // special // {
    "A-l" = [ "move_next_word_end" "move_char_right" ];
    "A-h" = [ "move_prev_word_start" ];
    "A-d" = [ "collapse_selection" "normal_mode" ];
    "i" = [ "collapse_selection" "insert_mode" ];
  };
}
