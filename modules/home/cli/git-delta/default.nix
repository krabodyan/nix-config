{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.git-delta;
in {
  options = {
    module.git-delta = {
      enable = mkEnableOption "enable git-delta";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [delta];

    programs.git.extraConfig = {
      core = {
        pager = "delta";
      };

      interactive = {
        diffFilter = "delta --color-only";
      };

      merge = {
        conflictstyle = "zdiff3";
      };

      delta = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
        relative-paths = true;
        generate-completion = "fish";
        dark = true;
        tabs = 4;

        map-styles = "bold purple => white strike dim \"#25171C\", bold cyan => yellow dim \"#12261E\", bold blue => white strike dim \"#25171C\", bold yellow => yellow dim \"#12261E\"";
        whitespace-error-style = "auto yellow";

        minus-style = "syntax \"#25171C\"";
        plus-style = "syntax \"#12261E\"";
        minus-emph-style = "syntax \"#6e2f32\"";
        plus-emph-style = "syntax \"#2d663e\"";
        minus-empty-line-marker-style = "normal \"#753237\"";
        plus-empty-line-marker-style = "normal \"#1E5937\"";

        line-numbers-minus-style = "red \"#542426\"";
        line-numbers-plus-style = "green \"#1C4428\"";
        line-numbers-left-format = "{nm:^6}";
        line-numbers-right-format = "{np:^6}";

        file-style = "omit";
        hunk-header-decoration-style = "white dim ol ul";
        hunk-header-line-number-style = "blue";
        hunk-header-file-style = "blue";
        hunk-header-style = "file line-number syntax";

        merge-conflict-ours-diff-header-style = "green";
        merge-conflict-ours-diff-header-decoration-style = "green";
        merge-conflict-theirs-diff-header-style = "red";
        merge-conflict-theirs-diff-header-decoration-style = "red";

        grep-file-style = "white dim";
        grep-line-number-style = "white dim";
        grep-match-word-style = "blue";
      };
    };
  };
}
