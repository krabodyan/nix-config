{
  lib,
  config,
  colors,
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
        nerdFontsVersion = 3;
        theme = with colors.hex; {
          activeBorderColor = [brgreen];
          inactiveBorderColor = [overlay0];
          selectedLineBgColor = [overlay0];
        };
      };
    };
  };
}
