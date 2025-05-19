{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.clang-format;
in {
  options = {
    module.clang-format = {
      enable = mkEnableOption "enable clang-format config";
    };
  };
  config = mkIf cfg.enable {
    home.file.".clang-format".text = ''
      BasedOnStyle: LLVM
      AllowShortFunctionsOnASingleLine: false
      IndentWidth: 4
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
