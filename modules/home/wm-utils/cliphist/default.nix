{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.cliphist;
in {
  options = {
    module.cliphist = {
      enable = mkEnableOption "cliphist";
    };
  };
  config = mkIf cfg.enable {
    services.cliphist = {
      enable = true;
      allowImages = false;
      extraOptions = [
        "-max-dedupe-search"
        "15"
        "-max-items"
        "15"
      ];
    };
  };
}
