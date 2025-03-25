let
  toggle = "A-d";
  binds = {
    "A-ret" = ["insert_mode" "insert_newline" "open_above" "insert_tab"];
    "A-S-h" = "unindent";
    "A-S-l" = "indent";
    "up" = "no_op";
    "down" = "no_op";
    "left" = "no_op";
    "right" = "no_op";

    "C-c" = "completion";
    "C-b" = ''
      :noop %sh{ gh browse %{buffer_name}:%{cursor_line} -c=%sh{ git rev-parse HEAD }}
    '';
    "C-S-b" = ''
      :sh gh browse %{filename:git_rel}:%{linenumber} -c=%sh{git rev-parse HEAD}
    '';

    "A-y" = "save_selection";
    "A-f" = ["goto_line_end" "move_char_right"];
    "A-g" = "goto_first_nonwhitespace";
    "A-a" = ["normal_mode" "goto_word"];

    "A-s" = [":w" "normal_mode" "collapse_selection" "commit_undo_checkpoint"];
    "A-e" = ":buffer-next";
    "A-w" = ":buffer-previous";

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
    "C-A-k" = [
      "normal_mode"
      "extend_line"
      "yank"
      "open_above"
      "normal_mode"
      "replace_with_yanked"
      "collapse_selection"
    ];
    "C-A-j" = [
      "normal_mode"
      "extend_line"
      "yank"
      "move_line_down"
      "open_above"
      "normal_mode"
      "replace_with_yanked"
      "collapse_selection"
    ];
    "A-=" = "increment";
    "A-minus" = "decrement";
  };
  special = {
    "<" = "no_op";
    ">" = "no_op";
    t = ["normal_mode" "extend_to_word"];
    "tab" = "no_op";
    "A-x" = "extend_line_up";
    "esc" = ["collapse_selection" "keep_primary_selection"];
    a = ["append_mode" "collapse_selection"];
    p = ":clipboard-paste-after";
    P = ":clipboard-paste-before";
    R = ":clipboard-paste-replace";
    y = ":clipboard-yank-join";
    Y = ":clipboard-yank";
    i = ["collapse_selection" "insert_mode"];
    "S-j" = "join_selections";
    "A-j" = "join_selections_space";
    "_" = "merge_selections";
    "A-c" = "copy_selection_on_next_line";
    "S-c" = "copy_selection_on_prev_line";
  };
in rec {
  insert =
    binds
    // {
      ${toggle} = "normal_mode";
      "ret" = ["insert_newline" "commit_undo_checkpoint"];
      "A-o" = "open_below";
      "A-p" = "open_above";
      "A-h" = "move_char_left";
      "A-l" = "move_char_right";
      "A-j" = "move_line_down";
      "A-k" = "move_line_up";
      "A-v" = ":clipboard-paste-before";
    };
  normal =
    binds
    // special
    // {
      ${toggle} = ["collapse_selection" "insert_mode"];
      "A-v" = ["select_mode" "flip_selections"];
      space = {
        q = ":q";
        Q = ":q!";
        c = ":buffer-close";
        C = ":buffer-close!";
        i = ":toggle lsp.display-inlay-hints";
        "S-c" = ":buffer-close!";
        "S-f" = ":open %sh{ __yazi_picker }";
        "A-f" = "file_picker_in_current_buffer_directory";
      };
    };
  select =
    binds
    // special
    // {
      ${toggle} = ["collapse_selection" "normal_mode"];
      "A-v" = "flip_selections";
      space = normal.space;
      "A-a" = "goto_word";
    };
}
