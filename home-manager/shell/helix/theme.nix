{ config, mkHex }:
{
  paradise = {
    "attribute" = "yellow";
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
    "variable.parameter" = {
      fg = "pink";
    };
    "variable.builtin" = "red";
    "variable.other.member" = "blue";

    "label" = "sapphire"; # used for lifetimes

    "punctuation" = "overlay0";
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

    "tag" = "accent";

    "namespace" = {
      fg = "yellow";
      modifiers = [ "italic" ];
    };

    "special" = "red";

    "markup.heading.marker" = {
      fg = "peach";
      modifiers = [ "bold" ];
    };
    "markup.heading.1" = "lavender";
    "markup.heading.2" = "lavender";
    "markup.heading.3" = "green";
    "markup.heading.4" = "yellow";
    "markup.heading.5" = "pink";
    "markup.heading.6" = "teal";
    "markup.list" = "lavender";
    "markup.bold" = {
      modifiers = [ "bold" ];
    };
    "markup.italic" = {
      modifiers = [ "italic" ];
    };
    "markup.link.url" = {
      fg = "blue";
      modifiers = [
        "italic"
        "underlined"
      ];
    };
    "markup.link.text" = "blue";
    "markup.raw" = "yellow";

    "diff.plus" = "green";
    "diff.minus" = "red";
    "diff.delta" = "blue";

    "ui.background" = { };

    "ui.linenr" = {
      fg = "surface1";
    };
    "ui.linenr.selected" = {
      fg = "accent";
    };
    "ui.statusline" = {
      fg = "overlay1";
      bg = "base";
    };
    "ui.statusline.inactive" = {
      fg = "overlay0";
      bg = "surface2";
    };
    "ui.statusline.normal" = {
      fg = "base";
      bg = "blue";
      modifiers = [ "bold" ];
    };
    "ui.statusline.insert" = {
      fg = "base";
      bg = "green";
      modifiers = [ "bold" ];
    };
    "ui.statusline.select" = {
      fg = "base";
      bg = "red";
      modifiers = [ "bold" ];
    };

    "ui.popup" = {
      fg = "text";
      bg = "surface0";
    };

    "ui.picker.header" = {
      fg = "comment";
    };

    "ui.window" = {
      fg = "text";
    };

    "ui.help" = {
      fg = "overlay0";
      bg = "surface0";
    };

    "ui.bufferline" = {
      fg = "comment";
      bg = "surface0";
      modifiers = [ "bold" ];
    };

    "ui.bufferline.active" = {
      fg = "subtext0";
      bg = "surface0";
      modifiers = [
        "bold"
      ];
    };

    "ui.bufferline.background" = {
      bg = "base";
    };

    "ui.text" = "text";
    "ui.text.focus" = {
      fg = "text";
      bg = "surface0";
      modifiers = [ "bold" ];
    };
    "ui.text.inactive" = {
      fg = "overlay1";
    };
    "ui.virtual" = "overlay0";
    "ui.virtual.ruler" = {
      bg = "surface0";
    };
    "ui.virtual.indent-guide" = "surface1";
    "ui.virtual.inlay-hint" = {
      fg = "comment";
      # bg = "mantle";
    };
    "ui.virtual.jump-label" = {
      fg = "red";
      modifiers = [ "bold" ];
    };

    "ui.selection" = {
      bg = "surface2";
    };

    "ui.cursor" = {
      fg = "base";
      bg = "secondary_cursor";
    };
    "ui.cursor.primary" = {
      fg = "base";
      bg = "accent";
    };
    "ui.cursor.match" = {
      fg = "red";
      # modifiers = [
      #   "underline"
      #   "bold"
      # ];
    };
    "ui.cursor.primary.normal" = {
      fg = "base";
      bg = "blue";
      # modifiers = [ "reversed" ];
    };
    "ui.cursor.primary.insert" = {
      bg = "base";
      fg = "text";
    };
    "ui.cursor.primary.select" = {
      fg = "base";
      bg = "red";
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

    "ui.cursorline.primary" = {
      bg = "surface0";
    };
    "ui.highlight" = {
      bg = "surface1";
      modifiers = [ "bold" ];
    };
    "ui.menu" = {
      fg = "overlay2";
      bg = "surface0";
    };
    "ui.menu.selected" = {
      fg = "text";
      bg = "surface1";
      modifiers = [ "bold" ];
    };

    "diagnostic.error" = {
      underline = {
        style = "curl";
      };
    };
    "diagnostic.warning" = {
      underline = {
        style = "curl";
      };
    };
    "diagnostic.info" = {
      underline = {
        style = "curl";
      };
    };
    "diagnostic.hint" = {
      underline = {
        style = "curl";
      };
    };
    "diagnostic.unnecessary" = {
      fg = "comment";
    };

    error = "red";
    warning = "yellow";
    info = "green";
    hint = "green";

    palette = with config.colors; {
      # rosewater = "#f5e0dc";
      # flamingo = "#f2cdcd";
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";

      accent = mkHex accent;
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
      mantle = "#181825";
      crust = "#11111b";
      secondary_cursor = "#b5a6a8";
      secondary_cursor_normal = "#878ec0";
      secondary_cursor_insert = "#7ea87f";
    };
  };
}
