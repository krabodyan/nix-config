{colors}: {
  paradise = with colors.hex; {
    "diagnostic.error" = {
      underline = {
        style = "curl";
        color = red;
      };
    };
    "diagnostic.info" = {};
    "diagnostic.hint" = {};
    "diagnostic.warning" = {};
    "diagnostic.unnecessary" = {
      fg = overlay1;
      modifiers = ["crossed_out"];
    };

    "error" = red;
    "warning" = yellow;
    "info" = yellow;
    "hint" = green;

    "type" = fg;

    "type.builtin" = brmagenta;
    "type.enum" = brmagenta;

    "constructor" = fg;

    "constant.builtin" = brred;
    "constant.numeric" = brred;
    "constant.character" = teal;
    "constant.character.escape" = brred;

    "string" = brblue;
    "string.regexp" = brmagenta;
    "string.special" = brmagenta;
    "string.special.symbol" = brred;
    "string.special.path" = brmagenta;

    "comment" = fg-dark;

    "variable" = fg;
    "variable.parameter" = fg;
    "variable.builtin" = fg;
    "variable.other.member" = fg;

    "label" = brred; # used for lifetimes

    "punctuation" = overlay1;
    "punctuation.bracket" = overlay2;
    "punctuation.special" = peach;

    "keyword" = brmagenta;
    "operator" = sky;

    "function" = fg;

    "function.macro" = fg;

    "tag" = brmagenta;

    "namespace" = fg;

    "special" = brred;

    "markup.heading.marker" = {
      fg = peach;
      modifiers = ["bold"];
    };
    "markup.heading.1" = sky;
    "markup.heading.2" = green;
    "markup.heading.3" = blue;
    "markup.heading.4" = yellow;
    "markup.heading.5" = magenta;
    "markup.heading.6" = teal;
    "markup.list" = sky;
    "markup.bold".modifiers = ["bold"];
    "markup.italic".modifiers = ["italic"];
    "markup.link.url" = blue;

    "markup.link.text" = blue;
    "markup.raw" = yellow;

    "diff.plus" = green;
    "diff.delta" = green;
    "diff.minus" = red;
    "diff.delta.moved" = yellow;
    "diff.delta.conflict" = brred;

    "ui.background" = {};

    "ui.linenr" = surface1;
    "ui.linenr.selected" = subtext0;
    "ui.statusline" = {
      fg = overlay0;
      bg = bg;
    };

    "ui.statusline.normal" = {
      fg = bg;
      modifiers = ["bold"];
    };
    "ui.statusline.insert" = {
      fg = bg;
      modifiers = ["bold"];
    };
    "ui.statusline.select" = {
      inherit fg;
      modifiers = ["bold"];
    };

    # help docs border
    "ui.popup" = {
      inherit bg;
      fg = surface3;
    };

    # space menu, m menu
    # borders
    "ui.popup.info" = {
      inherit bg;
      fg = surface3;
    };
    # text in space menu, m menu
    "ui.text.info" = subtext0;

    # autocomplete and its border
    "ui.menu" = {
      inherit bg;
      fg = surface3;
    };

    "ui.menu.selected" = subtext0;
    "ui.menu.scroll" = surface3;

    "ui.picker.header" = fg-dark;
    "ui.window" = surface0;

    "ui.bufferline" = {
      inherit bg;
      fg = surface3;
    };

    "ui.bufferline.active" = {
      fg = subtext0;
    };

    "ui.bufferline.background" = {
      inherit bg;
    };

    # menu in command mode :
    "ui.help" = {
      fg = overlay2;
      inherit bg;
    };

    # all text including statusline
    "ui.text" = fg;
    # previous command in command mode history
    "ui.text.inactive" = surface3;
    # dir in picker
    "ui.text.directory" = surface3;
    # focused file in picker
    "ui.text.focus" = {
      bg = surface1;
    };

    "ui.virtual" = overlay0;
    "ui.virtual.ruler" = {bg = bg-bright;};
    "ui.virtual.indent-guide" = bg-bright;
    "ui.virtual.inlay-hint" = fg-dark;
    "ui.virtual.jump-label" = {
      bg = surface2;
      fg = bryellow;
      modifiers = ["bold"];
    };

    "ui.selection" = {bg = surface2;};

    "ui.cursor" = {
      fg = bg;
    };
    "ui.cursor.primary" = {
      fg = bg;
    };
    # matching bracket
    "ui.cursor.match" = {
      fg = brred;
      underline.style = "line";
    };
    "ui.cursor.primary.normal" = {
      fg = bg;
      bg = mode_normal;
    };
    "ui.cursor.primary.insert" = {
      fg = bg;
      bg = mode_insert;
    };
    "ui.cursor.primary.select" = {
      fg = bg;
      bg = mode_select;
    };

    "ui.cursor.normal" = {
      fg = bg;
      bg = overlay2;
    };
    "ui.cursor.insert" = {
      fg = bg;
      bg = overlay2;
    };
    "ui.cursor.select" = {
      fg = bg;
      bg = overlay2;
    };

    "ui.cursorline.primary" = {bg = bg-bright;};
    "ui.highlight" = {
      fg = yellow;
      bg = surface1;
      modifiers = ["bold"];
    };
  };
}
