{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.clang-format;
in {
  options = {
    module.clang-format = {
      enable = mkEnableOption "clang-format config";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.gdb];
    home.file.".clang-format".text = ''
      BasedOnStyle: LLVM
      AllowShortFunctionsOnASingleLine: false
      IndentWidth: 4
      IndentExternBlock: Indent
      IndentCaseBlocks: false
      IndentCaseLabels: true
      BreakTemplateDeclarations: Yes
      PointerAlignment: Left
      AlignConsecutiveAssignments:
        Enabled:         true
      AlignConsecutiveBitFields:
        Enabled:         true
      AlignConsecutiveDeclarations:
        Enabled:         true
      AlignConsecutiveMacros:
        Enabled:         true
      AlignConsecutiveShortCaseStatements:
        Enabled:         true
      AlignConsecutiveTableGenCondOperatorColons:
        Enabled:         true
      AlignConsecutiveTableGenDefinitionColons:
        Enabled:         true
    '';
  };
}
