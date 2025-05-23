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
      enable = mkEnableOption "ripgrep";
    };
  };
  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
      arguments = [
        "--max-columns-preview"
        "--colors=line:fg:black"
        "--colors=line:style:intense"
        "--colors=path:fg:black"
        "--colors=path:style:intense"
        "--colors=match:fg:blue"
        "--ignore-case"
        "--glob=!.git/*"
      ];
    };
  };
}
