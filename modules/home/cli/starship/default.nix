{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.starship;
in {
  options = {
    module.starship = {
      enable = mkEnableOption "enable starship";
    };
  };
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = false;
      settings =
        {
          add_newline = false;
          format = lib.concatStrings [
            "$nix_shell"
            "$directory"
            "$git_branch"
            "$git_commit"
            "$git_state"
            "$git_status"
            "$character"
          ];
          scan_timeout = 10;
          character = {
            success_symbol = "󰧞";
            error_symbol = "󰧞";
          };

          directory = {
            truncation_length = 2;
            truncate_to_repo = true;
            fish_style_pwd_dir_length = 1;
            read_only = " [RO]";
            style = "$path$read_only ";
          };

          git_branch = {
            format = "[\\(](bright-black)[$branch](cyan)[\\)](bright-black) ";
            only_attached = true;
          };

          git_commit = {
            format = "[\\(](bright-black)[$hash](cyan)[\\)](bright-black) ";
            only_detached = true;
          };

          git_state = {
            format = "\([$state( $progress_current/$progress_total)]($style)\) ";
            disabled = false;
          };

          git_status = {
            format = "$all_status$ahead_behind";
            ahead = "[\${count}↑](red) ";
            behind = "[\${count}↓](red) ";
            conflicted = "[\${behind_count}↓ \${ahead_count}↑](red) ";
            untracked = "[\${count}?](red) ";
            modified = "[\${count}M](red) ";
            staged = "[\${count}M](green) ";
            stashed = "[\${count}S](bright-red) ";
            renamed = "[\${count}R](red) ";
            deleted = "[\${count}D](red) ";
            typechanged = "[\${count}T](bright-yellow) ";
            disabled = false;
            ignore_submodules = true;
          };
        }
        // lib.genAttrs [
          "aws"
          "battery"
          "buf"
          "bun"
          "c"
          "cmake"
          "cobol"
          "cmd_duration"
          "conda"
          "container"
          "crystal"
          "daml"
          "dart"
          "deno"
          "direnv"
          "docker_context"
          "dotnet"
          "elixir"
          "elm"
          "env_var"
          "erlang"
          "fennel"
          "fill"
          "fossil_branch"
          "fossil_metrics"
          "gcloud"
          "gleam"
          "golang"
          "guix_shell"
          "gradle"
          "haskell"
          "haxe"
          "helm"
          "hostname"
          "java"
          "jobs"
          "julia"
          "kotlin"
          "kubernetes"
          "line_break"
          "localip"
          "lua"
          "memory_usage"
          "meson"
          "hg_branch"
          "mojo"
          "nats"
          "nim"
          "nodejs"
          "ocaml"
          "odin"
          "opa"
          "openstack"
          "os"
          "package"
          "perl"
          "php"
          "pijul_channel"
          "pulumi"
          "purescript"
          "python"
          "quarto"
          "rlang"
          "raku"
          "red"
          "ruby"
          "rust"
          "scala"
          "shell"
          "shlvl"
          "singularity"
          "solidity"
          "spack"
          "status"
          "sudo"
          "swift"
          "terraform"
          "time"
          "typst"
          "username"
          "vagrant"
          "vlang"
          "vcsh"
          "zig"
        ] (_: {disabled = true;});
    };
  };
}
