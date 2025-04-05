{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.lazygit;
in {
  options = {
    module.lazygit = {
      enable = mkEnableOption "enable lazygit";
    };
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings.gui = {
        border = "single";
        theme = {
          activeBorderColor = ["green"];
          inactiveBorderColor = ["black"];
          selectedLineBgColor = ["black"];
        };
      };
    };
  };
}
