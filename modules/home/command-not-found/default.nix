{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.command-not-found;
in {
  options = {
    module.command-not-found = {
      enable = mkEnableOption "enable command-not-found";
    };
  };
  config = mkIf cfg.enable {
    programs.command-not-found.enable = true;
  };
}
