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
      sqlx-cli
      cargo-show-asm
      cargo-llvm-cov
      cargo-expand
      cargo-watch
    ];

    xdg.configFile."rustfmt/rustfmt.toml".text = ''
      edition = "2024"
      chain_width = 55
      max_width = 80
      comment_width = 100
      fn_call_width = 55
      binop_separator = "Front"
      group_imports = "StdExternalCrate"
      imports_granularity = "Module"
      hard_tabs = true
      tab_spaces = 4
      force_multiline_blocks = true
      newline_style = "Unix"
    '';
  };
}
