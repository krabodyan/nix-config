{ theme, mkHex }: {
  paradise = {

    "diagnostic.error" = { underline.style = "curl"; };
    "diagnostic.warning" = { underline.style = "curl"; };
    "diagnostic.info" = { underline.style = "curl"; };
    "diagnostic.hint" = { underline.style = "curl"; };
    "diagnostic.unnecessary" = { fg = "comment"; };

    error = "red";
    warning = "yellow";
    info = "green";
    hint = "green";

    # "attribute" = "yellow";
    "type" = {
      fg = "yellow";
      modifiers = [ "italic" ];
    };

    "type.builtin" = "mauve";
    "type.enum" = "yellow";

    "constructor" = "yellow";

    "constant.builtin" = "red";
    "constant.numeric" = "red";
    "constant.character" = "teal";
    "constant.character.escape" = "teal";

    "string" = "green";
    "string.regexp" = "pink";
    "string.special" = "blue";
    "string.special.symbol" = "red";
    "string.special.path" = "pink";

    "comment" = {
      fg = "comment";
      modifiers = [ "italic" ];
    };

    "variable" = "text";
    "variable.parameter" = { fg = "pink"; };
    "variable.builtin" = "red";
    "variable.other.member" = "blue";

    "label" = "sapphire"; # used for lifetimes

    "punctuation" = "overlay1";
    "punctuation.bracket" = "sky";
    "punctuation.special" = "peach";

    "keyword" = {
      fg = "mauve";
      modifiers = [ "italic" ];
    };
    "operator" = "sky";

    "function" = {
      fg = "blue";
      # modifiers = [ "italic" ];
    };
    # "function.builtin" = {
    #   fg = "peach";
    #   modifiers = [ "italic" ];
    # };
    "function.macro" = "red";

    "tag" = "sapphire";

    "namespace" = {
      fg = "text";
      modifiers = [ "italic" ];
    };

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
      modifiers = [ "italic" "underlined" ];
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
      fg = "subtext0";
      bg = "base";
    };
    "ui.statusline.active" = {
      fg = "overlay0";
      bg = "surface2";
    };
    "ui.statusline.normal" = {
      fg = "base";
      bg = "mode_normal";
      modifiers = [ "bold" ];
    };
    "ui.statusline.insert" = {
      fg = "base";
      bg = "mode_insert";
      modifiers = [ "bold" ];
    };
    "ui.statusline.select" = {
      fg = "base";
      bg = "mode_select";
      modifiers = [ "bold" ];
    };

    "ui.popup" = {
      fg = "text";
      bg = "bg-bright";
    };

    "ui.picker.header" = { fg = "comment"; };

    "ui.window" = { fg = "overlay0"; };

    "ui.help" = {
      fg = "overlay0";
      bg = "bg-bright";
    };

    "ui.bufferline" = {
      fg = "comment";
      bg = "base";
      modifiers = [ "bold" ];
    };

    "ui.bufferline.active" = {
      fg = "subtext0";
      bg = "surface0";
      modifiers = [ "bold" ];
    };

    "ui.bufferline.background" = { bg = "base"; };

    "ui.text" = "text";
    "ui.text.focus" = {
      fg = "text";
      bg = "surface0";
      modifiers = [ "bold" ];
    };
    "ui.text.inactive" = { fg = "overlay1"; };
    "ui.virtual" = "overlay0";
    "ui.virtual.ruler" = { bg = "surface0"; };
    "ui.virtual.indent-guide" = "surface1";
    "ui.virtual.inlay-hint" = { fg = "comment"; };
    "ui.virtual.jump-label" = {
      bg = "teal";
      fg = "base";
      # modifiers = [ "bold" "italic" ];
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
      fg = "red";
      bg = "surface1";
      # modifiers = [
      #   "underline"
      # "bold"
      # ];
    };
    "ui.cursor.primary.normal" = {
      fg = "base";
      bg = "mode_normal";
    };
    "ui.cursor.primary.insert" = {
      bg = "base";
      fg = "mode_insert";
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
      bg = "comment";
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
    "ui.menu" = {
      fg = "overlay2";
      bg = "bg-bright";
    };
    "ui.menu.selected" = {
      fg = "text";
      bg = "surface1";
      # modifiers = [ "bold" ];
    };
    "ui.menu.scroll" = {
      # bg = "red";
      fg = "overlay0";
    };

    palette = with theme; {
      teal = mkHex teal;
      sky = mkHex sky;
      sapphire = mkHex sapphire;
      pink = mkHex pink;
      mauve = mkHex magenta;
      red = mkHex red;
      peach = mkHex peach;
      yellow = mkHex yellow;
      green = mkHex green;
      blue = mkHex blue;
      text = mkHex fg;
      comment = mkHex fg-dark;
      subtext0 = mkHex subtext0;
      overlay2 = mkHex overlay2;
      overlay1 = mkHex overlay1;
      overlay0 = mkHex overlay0;
      surface2 = mkHex surface2;
      surface1 = mkHex surface1;
      surface0 = mkHex surface0;
      base = mkHex bg;
      bg-bright = mkHex bg-bright;
      mode_normal = mkHex mode_normal;
      mode_select = mkHex mode_select;
      mode_insert = mkHex mode_insert;
    };
  };
}
