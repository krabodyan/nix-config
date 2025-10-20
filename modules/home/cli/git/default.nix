{
  lib,
  pkgs,
  config,
  publicKey,
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
    programs.git = {
      enable = true;
      package = pkgs.gitMinimal;
      inherit (cfg) userName userEmail;

      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519";
        signByDefault = true;
      };

      aliases = let
        git-cleanup = pkgs.writeShellScriptBin "git-cleanup" ''
          for branch in $(git -c color.ui=false branch --merged master | grep -E -v '(^\*|master)'); do
          	read -r -p "delete branch $branch? [y/N]: " confirm
          	if [[ $confirm == "y" || $confirm == "Y" || $confirm == "yes" ]]; then
          		git branch -d "$branch"
          		git push origin --delete "$branch"
          	fi
          done
        '';
      in {
        graph = "log --oneline --all --graph --format=format:'%C(brightmagenta)%h%C(reset)%C(auto)%d%C(reset) %s%C(black) (%aN) %ar %C(reset)'";
        graph-branch = "log --oneline --graph --format=format:'%C(brightmagenta)%h%C(reset)%C(auto)%d%C(reset) %s%C(black) (%aN) %ar %C(reset)'";
        cleanup = "!${git-cleanup}/bin/git-cleanup";
      };

      attributes = [
        "*.svg binary"
        "*.json binary"
        "*.lock binary"
        "*.drawio binary"
      ];

      extraConfig = {
        gpg.ssh.allowedSignersFile = toString (
          pkgs.writeText "allowed_signers" ''
            ${cfg.userEmail} ${publicKey}
          ''
        );

        core = {
          untrackedCache = true;
          preloadIndex = true;
          fsmonitor = true;
        };

        transfer = {
          unpackLimit = 1;
        };

        init = {
          defaultbranch = "master";
        };

        index = {
          sparse = true;
          threads = true;
        };

        branch = {
          sort = "-committerdate";
        };

        fetch = {
          prune = true;
          parallel = 0;
        };

        merge = {
          ff = "only";
        };

        mergetool = {
          prompt = false;
          keepBackup = false;
          keepTemporaries = false;
        };

        rerere = {
          enabled = true;
          autoUpdate = true;
        };

        pull = {
          rebase = true;
          twohead = "ort";
        };

        rebase = {
          autoStash = true;
          autoSquash = true;
          updateRefs = true;
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

        color.ui = "always";

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

          # fix(fix): description
          # feat(feat): description
          # chore(chore): description
          # style(style): description
          # refactor(refactor): description

          # ci(ci): description
          # perf(perf): description
          # test(test): description
          # docs(docs): description
          # build(build): description
          # config(config): description

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
