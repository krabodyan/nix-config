{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.gcc;
in {
  options = {
    module.gcc = {
      enable = mkEnableOption "gcc";
    };
  };
  config = mkIf cfg.enable {
    programs.gcc = {
      enable = true;
      colors = {
        error = "31";
        warning = "33";
        note = "30";
        path = "30";
        range1 = "36";
        range2 = "36";
        locus = "30";
        quote = "35";
        fnname = "35";
        targs = "36";
        fixit-insert = "32";
        fixit-delete = "09;30";
        diff-filename = "36";
        diff-hunk = "36";
        diff-delete = "09;30";
        diff-insert = "32";
        type-diff = "36";
        valid = "32";
        invalid = "31";
        highlight-a = "36";
        highlight-b = "36";
      };
    };
  };
}
