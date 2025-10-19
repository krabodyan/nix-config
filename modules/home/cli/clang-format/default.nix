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
      AllowShortLambdasOnASingleLine: false
      AllowShortEnumsOnASingleLine: false
      AllowShortCaseExpressionOnASingleLine: false
      AllowShortBlocksOnASingleLine: false
      AllowAllArgumentsOnNextLine: false
      AllowAllParametersOfDeclarationOnNextLine: false

      IndentWidth: 4
      IndentExternBlock: Indent
      IndentCaseBlocks: false
      IndentCaseLabels: true

      BreakBeforeBraces: Custom
      BreakTemplateDeclarations: Yes
      BreakBeforeBinaryOperators: None
      BreakFunctionDefinitionParameters: false
      BreakConstructorInitializers: BeforeComma

      PointerAlignment: Left
      PackConstructorInitializers: Never

      BinPackArguments: false
      BinPackParameters: false

      PenaltyBreakAssignment: 120

      LambdaBodyIndentation: OuterScope
      MaxEmptyLinesToKeep: 2

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
