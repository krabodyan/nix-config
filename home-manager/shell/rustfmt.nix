{
  xdg.configFile."rustfmt/rustfmt.toml".text = ''
    chain_width = 35
    comment_width = 100
    format_code_in_doc_comments = true
    group_imports = "One"
    wrap_comments = true
    use_field_init_shorthand = true
    use_small_heuristics = "Max"
    hard_tabs = true
    tab_spaces = 1
    fn_call_width = 30
    force_multiline_blocks = true
    fn_params_layout = "Compressed"
    newline_style = "Unix"
  '';
}
