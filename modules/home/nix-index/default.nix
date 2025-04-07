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
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = false;
    };
    programs.nix-index-database.comma.enable = true;
  };
}
