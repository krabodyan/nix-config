{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.zsh;
in {
  options = {
    module.zsh = {
      enable = mkEnableOption "enable zsh";
    };
  };
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      history = {
        saveNoDups = true;
        save = 300;
      };
      defaultKeymap = "vicmd";
      # plugins = with pkgs; [
      #   {
      #     inherit (zsh-autosuggestions) src name;
      #   }
      # ];
      autosuggestion = {
        enable = true;
        strategy = ["completion" "history"];
      };
      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
