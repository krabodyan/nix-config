{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.rust-cli;
in {
  options = {
    module.rust-cli = {
      enable = mkEnableOption "rust related packages";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cargo-expand
      cargo-watch
      cargo-flamegraph
      # sqlx-cli
      # cargo-show-asm
      # cargo-llvm-cov
    ];

    xdg.configFile."rustfmt/rustfmt.toml".text =
      # toml
      ''
        edition = "2024"
        comment_width = 100
        max_width = 80
        fn_call_width = 55
        chain_width = 55
        binop_separator = "Back"
        combine_control_expr = false
        group_imports = "StdExternalCrate"
        imports_granularity = "Module"
        hard_tabs = true
        tab_spaces = 4
        force_multiline_blocks = true
        newline_style = "Unix"
      '';
  };
}
