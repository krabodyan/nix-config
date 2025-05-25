let
  toggle = "A-d";
  binds = {
    A-backspace = ["commit_undo_checkpoint" "delete_word_backward"];

    A-ret = [
      "insert_mode"
      "insert_newline"
      "commit_undo_checkpoint"
      "open_above"
      "commit_undo_checkpoint"
      "insert_tab"
    ];

    A-S-h = "unindent";
    A-S-l = "indent";

    tab = ["signature_help"];
    C-c = ["completion"];

    C-k = "kill_to_line_end";
    C-K = "kill_to_line_start";
    A-y = "save_selection";
    A-f = "goto_line_end_newline";
    A-g = "goto_first_nonwhitespace";
    A-a = ["normal_mode" "goto_word"];

    A-s = [":write" "normal_mode" "collapse_selection" "commit_undo_checkpoint"];
    A-S = [":write!" "normal_mode" "collapse_selection" "commit_undo_checkpoint"];

    A-e = "goto_next_buffer";
    A-w = "goto_previous_buffer";

    "A-/" = "toggle_comments";
    "A-7" = "toggle_comments";
    "A-?" = "toggle_block_comments";

    "A-=" = "increment";
    "A-minus" = "decrement";

    A-S-j = ["extend_to_line_bounds" "delete_selection" "paste_after"];
    A-S-k = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];

    C-A-k = [
      "trim_selections"
      "normal_mode"
      "extend_line"
      "yank"
      "open_above"
      "normal_mode"
      "replace_with_yanked"
      "collapse_selection"
    ];

    C-A-j = [
      "trim_selections"
      "normal_mode"
      "extend_line"
      "yank"
      "move_line_down"
      "open_above"
      "normal_mode"
      "replace_with_yanked"
      "collapse_selection"
    ];
  };

  special = {
    "=" = ":format";
    d = "delete_selection_noyank";
    c = "change_selection_noyank";
    D = "delete_word_forward";
    t = ["normal_mode" "extend_to_word"];
    a = ["append_mode" "collapse_selection"];

    P = "paste_before";
    p = ":clipboard-paste-before";
    R = ":clipboard-paste-replace";

    y = "yank_to_clipboard";
    Y = "yank";

    i = ["collapse_selection" "insert_mode"];

    M = "merge_selections";
    J = "join_selections_space";
    A-J = "join_selections_space";

    S-c = "copy_selection_on_next_line";
    A-c = "copy_selection_on_prev_line";

    C-r = ["insert_mode" "insert_register"];

    esc = ["collapse_selection" "keep_primary_selection"];

    C-b = [
      ":noop %sh{ gh browse %{buffer_name}:%{cursor_line} -b=%sh{ git rev-parse --abbrev-ref HEAD } }"
      ":echo opening in browser"
    ];

    ">" = "rotate_view";
    "<" = "rotate_view_reverse";
  };
in rec {
  insert =
    binds
    // {
      ${toggle} = "normal_mode";

      A-o = "open_below";
      A-p = "open_above";

      A-h = "move_char_left";
      A-j = "move_line_down";
      A-l = "move_char_right";
      A-k = "move_line_up";

      A-v = ":clipboard-paste-before";
    };

  normal =
    binds
    // special
    // {
      ${toggle} = ["collapse_selection" "insert_mode"];
      t = ["select_mode" "find_next_char"];
      T = ["select_mode" "find_prev_char"];

      space = {
        q = ":q";
        Q = ":q!";
        c = ":buffer-close";
        C = ":buffer-close!";
      };

      g = {
        d = ["vsplit" "goto_definition"];
      };

      f = {
        q = "wclose";
        c = "file_picker_in_current_buffer_directory";
        j = ":run-shell-command just";
        i = ":toggle lsp.display-inlay-hints";
        h = ":toggle end-of-line-diagnostics disable hint";
        s = ["search_selection_detect_word_boundaries" "select_all" "select_regex"];
        space = ":open %sh{ __yazi_picker %{buffer_name} }";
      };
    };

  select =
    binds
    // special
    // {
      ${toggle} = ["collapse_selection" "normal_mode"];

      f = normal.f;
      space = normal.space;

      A-a = "goto_word";
    };
}
