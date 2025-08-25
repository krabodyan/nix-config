{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.cli-default;
in {
  options = {
    module.cli-default = {
      enable = mkEnableOption "default cli apps";
      extra = mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
      };
      dev = mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        pv
        yq
        jiq

        csview

        xdg-utils

        dust
        dua
        dysk

        just
      ]
      ++ lib.optionals cfg.dev [
        gnumake
        gcc
        cmake

        lazydocker
        sqlfluff
        litecli
        mycli
        actionlint
      ]
      ++ cfg.extra;
  };
}
