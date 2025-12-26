{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.less;
in {
  options = {
    module.less = {
      enable = mkEnableOption "less";
    };
  };
  config = mkIf cfg.enable {
    programs.less = {
      enable = true;
      options = {
        RAW-CONTROL-CHARS = true;
        LONG-PROMPT = true;
        ignore-case = true;
        jump-target = 3;
        quit-if-one-screen = true;
        no-init = true;
        chop-long-lines = false;
        status-column = true;
        mouse = false;
      };
    };
  };
}
