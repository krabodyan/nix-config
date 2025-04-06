{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.nix-index;
in {
  options = {
    module.nix-index = {
      enable = mkEnableOption "enable nix-index";
    };
  };
  config = mkIf cfg.enable {
    programs.command-not-found.enable = false;
    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = false;
    };
  };
}
