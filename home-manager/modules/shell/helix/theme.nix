{ config, lib }:
let
  mkHex = color: "#${color}";
in
{
  catppuccin_mocha = with config.colors; {
    inherits = "catppuccin_mocha";
    "ui.background" = { };
    comment = {
      fg = mkHex fg-dark;
      modifiers = [ "italic" ];
    };

    "diagnostic.unnecessary" = {
      fg = mkHex cyan;
      underline = { };
      modifiers = [ ];
    };

    # "diagnostic.error" = {
    #   fg = "red";
    #   # modifiers = [ "underlined" ];
    # };
    # # "diagnostic.warning" = {
    # #   fg = mkHex yellow;
    # #   modifiers = [ "underlined" ];
    # # };
    # "diagnostic.deprecated" = {
    #   fg = mkHex cyan;
    #   # modifiers = [ "underlined" ];
    # };
    # "diagnostic.unnecessary" = {
    #   fg = mkHex fg-dark;
    #   underline = { };
    #   # modifiers = [ "crossed_out" ];
    # };

    type = {
      fg = mkHex blue;
      modifiers = [ "italic" ];
    };
    keyword = {
      fg = mkHex magenta;
      modifiers = [ "italic" ];
    };
    "variable.builtin" = {
      fg = "red";
      modifiers = [ "italic" ];
    };
    "variable.parameter" = {
      fg = "red";
      modifiers = [ "italic" ];
    };
    "variable.other".fg = "blue";
    "variable.other.member".fg = "blue";
    "punctuation.bracket".fg = "green";
    "punktuation.delimiter".fg = mkHex fg-dark;
    "punktuation.special".fg = mkHex red;
    function = {
      fg = "blue";
      modifiers = [ "italic" "bold" ];
    };
    operator = {
      fg = mkHex fg-dark;
      modifiers = [ "bold" ];
    };
    string.fg = "green";
    namespace.fg = mkHex fg;
    "constant.builtin".fg = mkHex magenta;
    "constant.character".fg = mkHex fg;
    "constant.numeric".fg = mkHex orange;
  };
}
