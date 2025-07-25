{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.python;
in {
  options = {
    module.python = {
      enable = mkEnableOption "python";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mypy
      python313Packages.ipython
      python313Full
    ];
  };
}
