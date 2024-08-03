{ config, mkHex }:
{
  catppuccin_mocha = with config.colors; {
    "attribute" = "yellow";
    "type" = {
      fg = "yellow";
      modifiers = [ "italic" ];
    };

    "type.builtin" = "mauve";
    "type.enum" = "yellow";

    "constructor" = "yellow";

    "constant.builtin" = "red";
    "constant.numeric" = "peach";
    "constant.character" = "teal";
    "constant.character.escape" = "maroon";

    "string" = "green";
    "string.regexp" = "pink";
    "string.special" = "blue";
    "string.special.symbol" = "red";
    "string.special.path" = "pink";

    "comment" = {
      fg = mkHex fg-dark;
      modifiers = [ "italic" ];
    };

    "variable" = "text";
    "variable.parameter" = {
      fg = "maroon";
      modifiers = [ "italic" ];
    };
    "variable.builtin" = "red";
    "variable.other.member" = "blue";

    "label" = "sapphire"; # used for lifetimes

    "punctuation" = "overlay2";
    "punctuation.bracket" = "sky";
    "punctuation.special" = "peach";

    "keyword" = {
      fg = "mauve";
      modifiers = [ "italic" ];
    };
    "operator" = "sky";

    "function" = {
      fg = "blue";
      modifiers = [ "italic" ];
    };
    # "function.builtin" = {
    #   fg = "peach";
    #   modifiers = [ "italic" ];
    # };
    # "function.macro" = "peach";

    "tag" = "lavender";

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
    "markup.raw" = "flamingo";

    "diff.plus" = "green";
    "diff.minus" = "red";
    "diff.delta" = "blue";

    # User Interface
    # --------------
    "ui.background" = { };

    "ui.linenr" = {
      fg = "surface1";
    };
    "ui.linenr.selected" = {
      fg = "lavender";
    };

    "ui.statusline" = {
      fg = "subtext1";
      bg = "cursorline";
    };
    "ui.statusline.inactive" = {
      fg = "surface2";
      bg = "cursorline";
    };
    "ui.statusline.normal" = {
      fg = "base";
      bg = "lavender";
      modifiers = [ "bold" ];
    };
    "ui.statusline.insert" = {
      fg = "base";
      bg = "green";
      modifiers = [ "bold" ];
    };
    "ui.statusline.select" = {
      fg = "base";
      bg = "flamingo";
      modifiers = [ "bold" ];
    };

    "ui.popup" = {
      fg = "text";
      bg = "surface0";
    };
    "ui.window" = {
      fg = "crust";
    };
    "ui.help" = {
      fg = "overlay2";
      bg = "surface0";
    };

    "ui.bufferline" = {
      fg = "subtext0";
      modifiers = [ "bold" ];
    };
    "ui.bufferline.active" = {
      fg = "lavender";
      bg = "surface0";
      modifiers = [ "bold" ];
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
    "ui.virtual.indent-guide" = "surface0";
    "ui.virtual.inlay-hint" = {
      fg = mkHex fg-dark;
      # bg = "mantle";
    };
    "ui.virtual.jump-label" = {
      fg = "rosewater";
      modifiers = [ "bold" ];
    };

    "ui.selection" = {
      bg = "surface1";
    };

    "ui.cursor" = {
      fg = "base";
      bg = "secondary_cursor";
    };
    "ui.cursor.primary" = {
      fg = "base";
      bg = "rosewater";
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
      bg = "lavender";
    };
    "ui.cursor.primary.insert" = {
      fg = "base";
      bg = "green";
    };
    "ui.cursor.primary.select" = {
      fg = "base";
      bg = "flamingo";
    };

    "ui.cursor.normal" = {
      fg = "base";
      bg = "secondary_cursor_normal";
    };
    "ui.cursor.insert" = {
      fg = "base";
      bg = "secondary_cursor_insert";
    };
    "ui.cursor.select" = {
      fg = "base";
      bg = "secondary_cursor";
    };

    "ui.cursorline.primary" = {
      bg = "cursorline";
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
      fg = mkHex fg-dark;
    };

    error = mkHex red;
    warning = mkHex yellow;
    info = mkHex green;
    hint = mkHex green;

    palette = {
      rosewater = "#f5e0dc";
      flamingo = "#f2cdcd";
      pink = "#f5c2e7";
      mauve = "#cba6f7";
      red = "#f38ba8";
      maroon = "#eba0ac";
      peach = "#fab387";
      yellow = "#f9e2af";
      green = mkHex brgreen;
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";
      blue = "#89b4fa";
      lavender = "#b4befe";
      text = "#d1d8ff";
      subtext1 = "#bac2de";
      subtext0 = "#a6adc8";
      overlay2 = "#9399b2";
      overlay1 = "#7f849c";
      overlay0 = "#6c7086";
      surface2 = "#585b70";
      surface1 = "#45475a";
      surface0 = "#313244";
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";
      cursorline = "#2a2b3c";
      secondary_cursor = "#b5a6a8";
      secondary_cursor_normal = "#878ec0";
      secondary_cursor_insert = "#7ea87f";
    };
  };
}
