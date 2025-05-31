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

        xdg-utils

        dust
        dua
        dysk

        pulsemixer
      ]
      ++ lib.optionals cfg.dev [
        gnumake
        just
        gcc

        postman
        # vagrant
        # tenv
        # ansible
        # cdrtools

        lazydocker
        sqlfluff
        litecli
        mycli
      ]
      ++ cfg.extra;
  };
}
