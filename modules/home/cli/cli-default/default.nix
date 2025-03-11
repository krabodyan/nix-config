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
      enable = mkEnableOption "enable default cli apps";
      extra = mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        jq
        eza
        xdg-utils

        python3
        ffmpeg
        dust
        dua
        duf
        exiftool

        pulsemixer
      ]
      ++ cfg.extra;
  };
}
