{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.printing;
in {
  options = {
    module.printing = {
      enable = mkEnableOption "printing";
    };
  };
  config = mkIf cfg.enable {
    services.printing.enable = true;
  };
}
