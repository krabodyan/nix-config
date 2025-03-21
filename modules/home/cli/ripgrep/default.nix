{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.ripgrep;
in {
  options = {
    module.ripgrep = {
      enable = mkEnableOption "enable ripgrep";
    };
  };
  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
      arguments = [
        "--max-columns-preview"
        "--colors=line:fg:red"
        "--colors=line:style:bold"
        "--colors=path:fg:magenta"
        "--colors=path:style:bold"
        "--colors=match:fg:black"
        "--colors=match:bg:white"
        "--ignore-case"
        "--glob=!.git/*"
      ];
    };
  };
}
