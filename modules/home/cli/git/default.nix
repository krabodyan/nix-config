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
      enable = mkEnableOption "git";
      userName = mkOption {
        type = lib.types.str;
      };
      userEmail = mkOption {
        type = lib.types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.actionlint];

    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;

      signing.format = "ssh";

      aliases = {
        s = "status";
        graph = "log --oneline --all --graph --format=format:'%C(brightmagenta)%h%C(reset)%C(auto)%d%C(reset) %s%C(black) - %ar%C(reset)'";
      };

      attributes = [
        "*.svg binary"
        "*.json binary"
        "*.lock binary"
        "*.drawio binary"
      ];

      extraConfig = {
        init = {
          defaultbranch = "master";
        };

        branch = {
          sort = "-committerdate";
        };

        fetch = {
          prune = true;
        };

        merge = {
          ff = "only";
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

        advice = {
          diverging = false;
          skippedCherryPicks = false;
          mergeConflict = false;
          detachedHead = false;
          addEmptyPathspec = false;
          statusHints = false;
          pushUpdateRejected = false;
          forceDeleteBranch = false;
        };

        commit.template = builtins.toString (pkgs.writeText "template.txt" ''
          # <type>[optional scope][!]: <description>
          # chore docs style refactor perf test

          # feat: description
          # feat(feat): description

          # chore: description
          # chore(chore): description

          # refactor: description
          # refactor(refactor): description

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
        ".cache"
        "tmp/"
        "*.tmp"
        "log/"
        "*.swp"

        # c commons
        "__pycache__"
        "cmake-build-debug"
        "compile_commands.json"
        "vgcore.*"
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
  };
}
