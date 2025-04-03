{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.gui-default;
in {
  options = {
    module.gui-default = {
      enable = mkEnableOption "enable default gui apps";
      extra = mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
      ]
      ++ cfg.extra;
  };
}
