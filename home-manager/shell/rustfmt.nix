{ pkgs, ... }: {
  # let
  #   rust = pkgs.rust-bin.nightly.latest.default.override {
  #     extensions = [
  #       "rust-src"
  #       "rust-analyzer"
  #     ];
  #   };
  # in
  # {
  # home.packages = with pkgs; [ rustup ];
  xdg.configFile."rustfmt/rustfmt.toml".text = ''
    chain_width = 55
    comment_width = 100
    binop_separator = "Back"
    # max_width = 80
    group_imports = "One"
    imports_granularity = "Module"
    reorder_imports = false
    # wrap_comments = true
    # brace_style = "PreferSameLine"
    use_field_init_shorthand = true
    # use_small_heuristics = "Off"
    hard_tabs = true
    tab_spaces = 1
    fn_call_width = 45
    force_multiline_blocks = true
    # fn_params_layout = "Vertical"
    # fn_args_layout = "Vertical"
    newline_style = "Unix"
    # indent_style = "Visual"
    # struct_lit_single_line = true
  '';
}
