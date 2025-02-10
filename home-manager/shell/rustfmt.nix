{
  xdg.configFile."rustfmt/rustfmt.toml".text = ''
    edition = "2021"
    chain_width = 55
    max_width = 70
    comment_width = 100
    fn_call_width = 45
    # array_width = 
    binop_separator = "Front"
    group_imports = "StdExternalCrate"
    imports_granularity = "Module"
    hard_tabs = true
    tab_spaces = 1
    force_multiline_blocks = true
    newline_style = "Unix"
  '';
}
