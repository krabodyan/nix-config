{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.git;
in {
  options = {
    module.git = {
      enable = mkEnableOption "enable git";
      userName = mkOption {
        type = lib.types.str;
      };
      userEmail = mkOption {
        type = lib.types.str;
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [gh lazygit delta];
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;

      signing.format = "ssh";

      aliases = {
        cm = "commit -m";
        st = "status";
        graph = "log --oneline --all --graph --format=format:'%C(brightmagenta)%h%C(reset)%C(auto)%d%C(reset) %s%C(black) - %ar%C(reset)'";
      };

      extraConfig = {
        advice = {
          skippedCherryPicks = false;
          mergeConflict = false;
          detachedHead = false;
        };

        core = {
          pager = "delta";
        };

        init = {
          defaultbranch = "master";
        };

        branch = {
          sort = "-committerdate";
        };

        fetch = {
          prune = true;
        };

        interactive = {
          diffFilter = "delta --color-only";
        };

        merge = {
          ff = "only";
          conflictstyle = "zdiff3";
        };

        rerere = {
          enabled = true;
          autoUpdate = true;
        };

        pull = {
          rebase = true;
        };

        rebase = {
          autoStash = true;
        };

        stash = {
          showIncludeUntracked = true;
        };

        push = {
          autoSetupRemote = true;
          default = "simple";
        };

        diff = {
          algorithm = "histogram";
          colorMoved = "default";
        };

        safe.directory = "*";

        delta = {
          line-numbers = true;
          side-by-side = false;
          navigate = true;
          relative-paths = true;
          dark = true;
          tabs = 4;

          map-styles = "bold purple => white strike dim \"#25171C\", bold cyan => yellow dim ul \"#12261E\", bold blue => yellow dim ul \"#12261E\"";
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
        };

        commit.template = builtins.toString (pkgs.writeText "template.txt" ''
          # <type>[optional scope][!]: <description>
          # chore docs style refactor perf test

          # feat: description
          # feat(feat): description

          # chore: description
          # chore(chore): description

          # style: description
          # style(style): description

          # fix: description
          # fix(fix): description

          # BREAKING CHANGE: description
        '');
      };

      ignores = [
        "*.bak"
        ".cache/"
        "tmp/"
        "*.tmp"
        "log/"
        "*.swp"

        # c commons
        "__pycache__"
        "cmake-build-debug"
        "compile_commands.json"
        "vgcore.*"
        ".cache"
        ".tags"
        "tags"
        "*~"
        "*.o"
        "*.so"
        "*.cmake"
        "*.gc??"
        "CMakeCache.txt"
        "CMakeFiles/"
        "cmake-build-debug/"
        "compile_commands.json"
        ".ccls*"
        "*.out"

        # node
        "node_modules"

        # locked files
        "*~"

        # nix
        "result"
        "result-*"
        ".direnv/"

        # ide folders
        ".editorconfig"
        ".vscode"
        ".idea"
        ".vs"
        ".devenv.*"
        "venv"

        # rust
        "target"

        # 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
        "mov"
        "mp4"
        "mkv"
        "mp3"
        "zip"
        "tar.gz"
        "tar"
        "pdf"
        "tar.xz"
      ];
    };

    xdg.configFile."lazygit/config.yml".text = ''
      gui:
        border: single
        theme:
          activeBorderColor:
            - green
          inactiveBorderColor:
            - black
          selectedLineBgColor:
            - black
    '';
  };
}
