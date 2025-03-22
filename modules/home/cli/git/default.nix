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
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      signing.format = "ssh";
      aliases = {
        cm = "commit -m";
        st = "status -sb";
        graph = "log --oneline --all --graph";
      };
      extraConfig = {
        init.defaultbranch = "master";
        branch.sort = "-committerdate";
        advice.skippedCherryPicks = false;
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
        "target"
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
      ];
    };
  };
}
