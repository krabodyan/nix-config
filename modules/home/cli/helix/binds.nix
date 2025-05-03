let
  toggle = "A-d";
  binds = {
    "up" = "no_op";
    "down" = "no_op";
    "left" = "no_op";
    "right" = "no_op";
    "A-backspace" = "delete_word_backward";

    "A-ret" = ["insert_mode" "insert_newline" "open_above" "insert_tab"];
    "A-S-h" = "unindent";
    "A-S-l" = "indent";

    "C-c" = "completion";

    "A-y" = "save_selection";
    "A-f" = "goto_line_end_newline";
    "A-g" = "goto_first_nonwhitespace";
    "A-a" = ["normal_mode" "goto_word"];

    "A-s" = [":w" "normal_mode" "collapse_selection" "commit_undo_checkpoint"];
    "A-e" = ":buffer-next";
    "A-w" = ":buffer-previous";

    "A-/" = "toggle_comments";
    "A-7" = "toggle_comments";
    "A-?" = "toggle_block_comments";

    "A-S-k" = ["normal_mode" "goto_line_end" "extend_line_below" "delete_selection" "move_line_up" "paste_before"];
    "A-S-j" = ["normal_mode" "goto_line_end" "extend_line_below" "delete_selection" "paste_after"];
    "C-A-k" = ["trim_selections" "normal_mode" "extend_line" "yank" "open_above" "normal_mode" "replace_with_yanked" "collapse_selection"];
    "C-A-j" = ["trim_selections" "normal_mode" "extend_line" "yank" "move_line_down" "open_above" "normal_mode" "replace_with_yanked" "collapse_selection"];

    "A-=" = "increment";
    "A-minus" = "decrement";
  };
  special = {
    "tab" = "no_op";
    "<" = "no_op";
    ">" = "no_op";

    "=" = ":format";
    d = "delete_selection_noyank";
    D = "delete_word_forward";
    t = ["normal_mode" "extend_to_word"];
    a = ["append_mode" "collapse_selection"];
    p = ":clipboard-paste-after";
    P = "paste_before";
    R = ":clipboard-paste-replace";
    y = ":clipboard-yank";
    Y = "yank";
    i = ["collapse_selection" "insert_mode"];

    J = "join_selections";
    "C-j" = "join_selections_space";
    "S-m" = "merge_selections";

    "S-c" = "copy_selection_on_next_line";
    "A-c" = "copy_selection_on_prev_line";

    "C-r" = ["insert_mode" "insert_register"];
    "C-b" = [":pipe base64"];
    "C-A-b" = [":pipe base64 -d"];

    esc = ["collapse_selection" "keep_primary_selection"];
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
      f = ["select_mode" "find_next_char"];
      F = ["select_mode" "find_prev_char"];
      space = {
        q = ":q";
        Q = ":q!";
        c = ":buffer-close";
        C = ":buffer-close!";
        i = ":toggle lsp.display-inlay-hints";
        h = ":toggle end-of-line-diagnostics disable hint";
        B = ":echo %sh{git blame --date=short -L %{cursor_line},+1 %{buffer_name}}";
        G = [
          ":noop %sh{ gh browse %{buffer_name}:%{cursor_line} -c=%sh{ git rev-parse HEAD }}"
          ":echo opening in browser"
        ];
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
      space = normal.space;
      "A-a" = "goto_word";
    };
}
