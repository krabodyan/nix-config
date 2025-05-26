{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.git.gh;
in {
  options = {
    module.git.gh = {
      enable = mkEnableOption "gh";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.gh];
  };
}
