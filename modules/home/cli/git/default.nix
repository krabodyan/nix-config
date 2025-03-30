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
    home.packages = with pkgs; [gh lazygit];
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

    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      signing.format = "ssh";
      aliases = {
        cm = "commit -m";
        s = "status -sb";
        st = "status";
        graph = "log --oneline --all --graph --format=format:'%C(brightmagenta)%h%C(reset)%C(auto)%d%C(reset) %s%C(black) - %ar%C(reset)'";
      };
      extraConfig = {
        init.defaultbranch = "master";
        branch.sort = "-committerdate";
        advice = {
          skippedCherryPicks = false;
          mergeConflict = false;
          detachedHead = false;
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
        rerere = {
          enabled = true;
          autoUpdate = true;
        };
        pull.rebase = true;
        rebase.autoStash = true;
        stash.showIncludeUntracked = true;
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
        diff.algorithm = "histogram";
        safe.directory = "*";
      };
      ignores = [
        "*.bak"
        # c commons
        "__pycache__"
        "cmake-build-debug"
        "compile_commands.json"
        "vgcore.*"
        ".cache"
        "*.gc??"
        "node_modules"
        # locked files
        "*~"
        # nix buid
        "result"
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
