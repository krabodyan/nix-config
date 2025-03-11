{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.rustfmt;
in {
  options = {
    module.rustfmt = {
      enable = mkEnableOption "enable rustfmt";
    };
  };
  config = mkIf cfg.enable {
    xdg.configFile."rustfmt/rustfmt.toml".text = ''
      edition = "2021"
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
