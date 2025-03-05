{ theme }: {
  paradise = {
    "diagnostic.error" = { underline.style = "curl"; };
    "diagnostic.warning" = { underline.style = "curl"; };
    "diagnostic.info" = { underline.style = "curl"; };
    "diagnostic.hint" = { underline.style = "curl"; };
    "diagnostic.unnecessary" = { fg = "comment"; };

    error = "red";
    warning = "yellow";
    info = "overlay1";
    hint = "overlay1";

    "type" = { fg = "text"; };

    "type.builtin" = "magenta";
    "type.enum" = "magenta";

    "constructor" = "text";

    "constant.builtin" = "red";
    "constant.numeric" = "red";
    "constant.character" = "teal";
    "constant.character.escape" = "teal";

    "string" = "blue";
    "string.regexp" = "pink";
    "string.special" = "blue";
    "string.special.symbol" = "red";
    "string.special.path" = "pink";

    "comment" = { fg = "comment"; };

    "variable" = "text";
    "variable.parameter" = "text";
    "variable.builtin" = "text";
    "variable.other.member" = "text";

    "label" = "red"; # used for lifetimes

    "punctuation" = "overlay1";
    "punctuation.bracket" = "overlay2";
    "punctuation.special" = "peach";

    "keyword" = { fg = "magenta"; };
    "operator" = "sky";

    "function" = { fg = "text"; };

    # "function.builtin" = {
    #   fg = "peach";
    #   modifiers = [ "italic" ];
    # };

    "function.macro" = "text";

    "tag" = "sapphire";

    "namespace" = { fg = "text"; };

    "special" = "red";

    "markup.heading.marker" = {
      fg = "peach";
      modifiers = [ "bold" ];
    };
    "markup.heading.1" = "sky";
    "markup.heading.2" = "sky";
    "markup.heading.3" = "green";
    "markup.heading.4" = "yellow";
    "markup.heading.5" = "pink";
    "markup.heading.6" = "teal";
    "markup.list" = "sky";
    "markup.bold" = { modifiers = [ "bold" ]; };
    "markup.italic" = { modifiers = [ "italic" ]; };
    "markup.link.url" = {
      fg = "blue";
      modifiers = [ "underlined" ];
    };
    "markup.link.text" = "blue";
    "markup.raw" = "yellow";

    "diff.plus" = "green";
    "diff.minus" = "red";
    "diff.delta" = "blue";

    "ui.background" = { };

    "ui.linenr" = { fg = "surface1"; };
    "ui.linenr.selected" = { fg = "subtext0"; };
    "ui.statusline" = {
      fg = "overlay0";
      bg = "base";
    };
    "ui.statusline.active" = {
      fg = "overlay0";
      bg = "base";
    };

    "ui.statusline.normal" = {
      fg = "base";
      # bg = "mode_normal";
      modifiers = [ "bold" ];
    };
    "ui.statusline.insert" = {
      fg = "base";
      # bg = "mode_insert";
      modifiers = [ "bold" ];
    };
    "ui.statusline.select" = {
      fg = "base";
      # bg = "mode_select";
      modifiers = [ "bold" ];
    };

    # popup = space
    "ui.popup" = {
      fg = "overlay0";
      bg = "base";
    };
    "ui.popup.info" = {
      fg = "text";
      bg = "base";
    };
    # ui.menu = autocomplete
    "ui.menu" = {
      fg = "overlay0";
      bg = "base";
    };
    "ui.menu.selected" = { fg = "text"; };
    "ui.menu.scroll" = { fg = "surface2"; };

    "ui.picker.header" = { fg = "comment"; };
    "ui.window" = { fg = "surface1"; };
    "ui.help" = { # menu in command mode :
      fg = "overlay0";
      bg = "base";
    };
    "ui.bufferline" = {
      fg = "surface2";
      bg = "base";
    };
    "ui.bufferline.active" = { fg = "subtext0"; };
    "ui.bufferline.background" = { bg = "base"; };

    "ui.text" = "text";
    "ui.text.inactive" = { fg = "overlay1"; };
    "ui.text.focus" = {
      fg = "text";
      bg = "surface1";
      # modifiers = [ "bold" ];
    };

    "ui.virtual" = "overlay0";
    "ui.virtual.ruler" = { bg = "surface0"; };
    "ui.virtual.indent-guide" = "surface1";
    "ui.virtual.inlay-hint" = { fg = "comment"; };
    "ui.virtual.jump-label" = {
      bg = "surface2";
      fg = "sky";
    };

    "ui.selection" = { bg = "surface2"; };

    "ui.cursor" = {
      fg = "base";
      bg = "overlay2";
    };
    "ui.cursor.primary" = {
      fg = "base";
      bg = "mode_normal";
    };
    # matching bracket
    "ui.cursor.match" = {
      fg = "magenta";
      modifiers = [ "underlined" ];
    };
    "ui.cursor.primary.normal" = {
      fg = "base";
      bg = "mode_normal";
    };
    "ui.cursor.primary.insert" = {
      fg = "base";
      bg = "base";
    };
    "ui.cursor.primary.select" = {
      fg = "base";
      bg = "mode_select";
    };

    "ui.cursor.normal" = {
      fg = "base";
      bg = "overlay2";
    };
    "ui.cursor.insert" = {
      fg = "base";
      bg = "overlay2";
    };
    "ui.cursor.select" = {
      fg = "base";
      bg = "overlay2";
    };

    "ui.cursorline.primary" = { bg = "bg-bright"; };
    "ui.highlight" = {
      fg = "yellow";
      bg = "surface1";
      modifiers = [ "bold" ];
    };

    palette = with theme.colorsHex; {
      teal = teal;
      sky = sky;
      sapphire = sapphire;
      pink = pink;
      magenta = brmagenta;
      red = red;
      peach = peach;
      yellow = yellow;
      green = green;
      blue = blue;
      text = fg;
      comment = fg-dark;
      subtext0 = subtext0;
      overlay2 = overlay2;
      overlay1 = overlay1;
      overlay0 = overlay0;
      surface2 = surface2;
      surface1 = surface1;
      surface0 = surface0;
      base = bg;
      bg-bright = bg-bright;
      mode_normal = mode_normal;
      mode_select = mode_select;
      mode_insert = mode_insert;
    };
  };
}
