{colors}: {
  paradise = with colors.hex; {
    "diagnostic.error" = {
      underline.style = "curl";
      underline.color = red;
    };
    "diagnostic.warning" = {
      underline.style = "curl";
      underline.color = yellow;
    };
    "diagnostic.info" = {
      underline.style = "curl";
      underline.color = yellow;
    };
    "diagnostic.hint" = {
      underline.style = "curl";
      underline.color = yellow;
    };
    "diagnostic.unnecessary" = {
      underline.color = fg-dark;
      fg = fg-dark;
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
    "string.special.symbol" = red;
    "string.special.path" = brmagenta;

    "comment" = fg-dark;

    "variable" = fg;
    "variable.parameter" = fg;
    "variable.builtin" = fg;
    "variable.other.member" = fg;

    "label" = red; # used for lifetimes

    "punctuation" = overlay1;
    "punctuation.bracket" = overlay2;
    "punctuation.special" = peach;

    "keyword" = brmagenta;
    "operator" = sky;

    "function" = fg;

    "function.macro" = fg;

    "tag" = brmagenta;

    "namespace" = fg;

    "special" = red;

    "markup.heading.marker" = {
      fg = peach;
      modifiers = ["bold"];
    };
    "markup.heading.1" = sky;
    "markup.heading.2" = sky;
    "markup.heading.3" = green;
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
    "diff.minus" = red;
    "diff.delta" = blue;

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

    # popup = space
    "ui.popup" = {
      fg = overlay0;
      inherit bg;
    };
    "ui.popup.info" = {
      inherit fg bg;
    };
    # ui.menu = autocomplete
    "ui.menu" = {
      fg = overlay0;
      inherit bg;
    };
    "ui.menu.selected" = fg;
    "ui.menu.scroll" = surface2;

    "ui.picker.header" = fg-dark;
    "ui.window" = surface1;
    "ui.help" = {
      # menu in command mode :
      fg = overlay0;
      inherit bg;
    };
    "ui.bufferline" = {
      fg = surface2;
      inherit bg;
    };
    "ui.bufferline.active" = subtext0;
    "ui.bufferline.background" = {bg = bg;};

    "ui.text" = fg;
    "ui.text.inactive" = overlay1;
    "ui.text.focus" = {
      inherit fg;
      bg = surface1;
    };

    "ui.virtual" = overlay0;
    "ui.virtual.ruler" = {bg = bg-bright;};
    "ui.virtual.indent-guide" = bg-bright;
    "ui.virtual.inlay-hint" = fg-dark;
    "ui.virtual.jump-label" = {
      bg = surface2;
      fg = green;
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
      underline.style = "line";
      fg = magenta;
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
      bg = overlay1;
    };
    "ui.cursor.insert" = {
      fg = bg;
      bg = overlay1;
    };
    "ui.cursor.select" = {
      fg = bg;
      bg = overlay1;
    };

    "ui.cursorline.primary" = {bg = bg-bright;};
    "ui.highlight" = {
      fg = yellow;
      bg = surface1;
      modifiers = ["bold"];
    };
  };
}
