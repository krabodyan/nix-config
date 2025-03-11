{colors}: let
  underline = {underline.style = "curl";};
in {
  paradise = with colors.hex; {
    "diagnostic.error" = underline;
    "diagnostic.warning" = underline;
    "diagnostic.info" = underline;
    "diagnostic.hint" = underline;
    "diagnostic.unnecessary" = {fg = fg-dark;};

    error = red;
    warning = yellow;
    info = overlay2;
    hint = overlay2;

    "type" = {fg = fg;};

    "type.builtin" = magenta;
    "type.enum" = magenta;

    "constructor" = fg;

    "constant.builtin" = red;
    "constant.numeric" = red;
    "constant.character" = teal;
    "constant.character.escape" = teal;

    "string" = blue;
    "string.regexp" = pink;
    "string.special" = blue;
    "string.special.symbol" = red;
    "string.special.path" = pink;

    "comment" = {fg = fg-dark;};

    "variable" = fg;
    "variable.parameter" = fg;
    "variable.builtin" = fg;
    "variable.other.member" = fg;

    "label" = red; # used for lifetimes

    "punctuation" = overlay1;
    "punctuation.bracket" = overlay2;
    "punctuation.special" = peach;

    "keyword" = {fg = magenta;};
    "operator" = sky;

    "function" = {fg = fg;};

    # "function.builtin" = {
    #   fg = "peach";
    #   modifiers = [ "italic" ];
    # };

    "function.macro" = fg;

    "tag" = sapphire;

    namespace = {fg = fg;};

    special = red;

    "markup.heading.marker" = {
      fg = peach;
      modifiers = ["bold"];
    };
    "markup.heading.1" = sky;
    "markup.heading.2" = sky;
    "markup.heading.3" = green;
    "markup.heading.4" = yellow;
    "markup.heading.5" = pink;
    "markup.heading.6" = teal;
    "markup.list" = sky;
    "markup.bold" = {modifiers = ["bold"];};
    "markup.italic" = {modifiers = ["italic"];};
    "markup.link.url" =
      underline
      // {
        fg = blue;
      };

    "markup.link.text" = blue;
    "markup.raw" = yellow;

    "diff.plus" = green;
    "diff.minus" = red;
    "diff.delta" = blue;

    "ui.background" = {};

    "ui.linenr" = {fg = surface1;};
    "ui.linenr.selected" = {fg = subtext0;};
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
    "ui.menu.selected" = {fg = fg;};
    "ui.menu.scroll" = {fg = surface2;};

    "ui.picker.header" = {fg = fg-dark;};
    "ui.window" = {fg = surface1;};
    "ui.help" = {
      # menu in command mode :
      fg = overlay0;
      inherit bg;
    };
    "ui.bufferline" = {
      fg = surface2;
      inherit bg;
    };
    "ui.bufferline.active" = {fg = subtext0;};
    "ui.bufferline.background" = {bg = bg;};

    "ui.text" = fg;
    "ui.text.inactive" = {fg = overlay1;};
    "ui.text.focus" = {
      inherit fg;
      bg = surface1;
    };

    "ui.virtual" = overlay0;
    "ui.virtual.ruler" = {bg = surface0;};
    "ui.virtual.indent-guide" = surface1;
    "ui.virtual.inlay-hint" = {fg = fg-dark;};
    "ui.virtual.jump-label" = {
      bg = surface2;
      fg = sky;
    };

    "ui.selection" = {bg = surface2;};

    "ui.cursor" = {
      fg = bg;
      bg = overlay2;
    };
    "ui.cursor.primary" = {
      fg = bg;
      bg = mode_normal;
    };
    # matching bracket
    "ui.cursor.match" =
      underline
      // {
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
