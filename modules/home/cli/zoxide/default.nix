{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.zoxide;
in {
  options = {
    module.zoxide = {
      enable = mkEnableOption "enables zoxide";
    };
  };
  config = mkIf cfg.enable {
    home.sessionVariables._ZO_FZF_OPTS = assert config.module.fzf.enable; let
      colors = config.programs.fzf.colors;
    in
      builtins.concatStringsSep " " config.programs.fzf.defaultOptions
      + " --color "
      + builtins.concatStringsSep "," (map (n: "${n}:${colors.${n}}") (builtins.attrNames colors));

    programs.zoxide = {
      enable = true;
      enableFishIntegration = config.module.fish.enable;
      options = ["--cmd cd"];
    };
  };
}
