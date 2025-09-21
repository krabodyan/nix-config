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
        error = "01;31";
        warning = "01;33";
        note = "01;30";
        locus = "01;30";
        caret = "01;36";
        quote = "01;34";
        fixit = "01;32";
        path = "01;30";
        function = "01;33";
      };
    };
  };
}
