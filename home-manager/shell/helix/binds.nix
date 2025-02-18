let
  toggle = "A-d";
  binds = {
    "C-f" = "file_picker_in_current_buffer_directory";
    "C-c" = "completion";
    "C-b" = ''
      :noop %sh{ gh browse %{buffer_name}:%{cursor_line} -c=%sh{ git rev-parse HEAD }}
    '';
    "C-S-b" = ''
      :sh gh browse %{filename:git_rel}:%{linenumber} -c=%sh{git rev-parse HEAD}
    '';
    # "A-w" = "rotate_view;
    "A-f" = [ "goto_line_end" "move_char_right" ];
    "A-a" = [ "normal_mode" "goto_word" ];

    "A-s" =
      [ ":w" "normal_mode" "collapse_selection" "commit_undo_checkpoint" ];
    "A-e" = ":buffer-next";
    "A-q" = ":buffer-previous";

    "A-/" = "toggle_comments";
    "A-7" = "toggle_comments";
    "A-?" = "toggle_block_comments";

    "A-S-k" = [
      "normal_mode"
      "goto_line_end"
      "extend_line_below"
      "delete_selection"
      "move_line_up"
      "paste_before"
    ];
    "A-S-j" = [
      "normal_mode"
      "goto_line_end"
      "extend_line_below"
      "delete_selection"
      "paste_after"
    ];
    "C-S-up" = [
      "normal_mode"
      "extend_line"
      "yank"
      "open_above"
      "normal_mode"
      "replace_with_yanked"
      "collapse_selection"
      "insert_mode"
    ];
    "C-S-down" = [
      "normal_mode"
      "extend_line"
      "yank"
      "move_line_down"
      "open_above"
      "normal_mode"
      "replace_with_yanked"
      "collapse_selection"
      "insert_mode"
    ];
    "A-=" = "increment";
    "A-minus" = "decrement";
  };
  special = {
    t = [ "normal_mode" "extend_to_word" ];
    "tab" = "no_op";
    "A-x" = "extend_line_up";
    "esc" = [ "collapse_selection" "keep_primary_selection" ];
    a = [ "append_mode" "collapse_selection" ];
    p = ":clipboard-paste-after";
    P = ":clipboard-paste-before";
    R = ":clipboard-paste-replace";
    y = ":clipboard-yank-join";
    Y = ":clipboard-yank";
    i = [ "collapse_selection" "insert_mode" ];
  };
in {
  normal = binds // special // {
    ${toggle} = [ "collapse_selection" "insert_mode" ];
    "A-l" = [ "move_next_word_end" "collapse_selection" "move_char_right" ];
    "A-h" = [ "move_prev_word_start" "collapse_selection" ];

    space = {
      q = ":q";
      Q = ":q!";
      c = ":buffer-close";
      C = ":buffer-close!";
      "S-c" = ":buffer-close!";
      "S-f" = ":open %sh{ __yazi_picker }";
    };
  };
  insert = binds // {
    ${toggle} = "normal_mode";
    "ret" = [ "insert_newline" "commit_undo_checkpoint" ];
    "A-o" = "open_below";
    "A-p" = "open_above";
    "A-h" = "move_char_left";
    "A-l" = "move_char_right";
    "A-j" = "move_line_down";
    "A-k" = "move_line_up";
  };
  select = binds // special // {
    ${toggle} = [ "collapse_selection" "normal_mode" ];
    "A-l" = [ "move_next_word_end" "move_char_right" ];
    "A-h" = [ "move_prev_word_start" ];
    "A-v" = "flip_selections";
  };
}
