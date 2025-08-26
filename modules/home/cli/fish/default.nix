{
  lib,
  pkgs,
  config,
  colors,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.fish;
in {
  options = {
    module.fish = {
      enable = mkEnableOption "fish";

      prompt = {
        kubectl = mkOption {
          type = lib.types.bool;
          description = "kubectl context and namespace";
          default = false;
          example = true;
        };

        ssh = mkOption {
          type = lib.types.bool;
          description = "show ssh connection status";
          default = false;
          example = true;
        };
      };

      aliases = {
        git = mkOption {
          type = lib.types.bool;
          description = "git aliases";
          default = false;
          example = true;
        };

        podman = mkOption {
          type = lib.types.bool;
          description = "podman aliases";
          default = false;
          example = true;
        };

        docker = mkOption {
          type = lib.types.bool;
          description = "docker aliases";
          default = false;
          example = true;
        };

        kubectl = mkOption {
          type = lib.types.bool;
          description = "kubectl aliases";
          default = false;
          example = true;
        };
      };

      loginShell = {
        enable = mkEnableOption "fish loginshell";

        wm = mkOption {
          type = lib.types.enum ["river" "sway"];
          example = "river";
        };

        withIGPU = mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      package = pkgs.fishMinimal;

      shellAbbrs = lib.mkMerge [
        {
          cpr = "rsync -arvP";
          cp = "cp -vr";
        }
        (
          mkIf cfg.aliases.git {
            ga = "git add";
            gp = "git push";
            gpf = "git push --force-with-lease";

            gc = "git commit";
            gs = "git status";

            gr = "git restore";
            grs = "git restore --staged";

            gg = "git graph -10";

            cm = {
              command = "git";
              expansion = "commit -m \"%\"";
              setCursor = true;
            };
            cma = {
              command = "git";
              expansion = "commit --all -m \"%\"";
              setCursor = true;
            };
          }
        )
        (
          mkIf (cfg.aliases.podman) ({
              d = "podman";
              docker = "podman";
              dcu = "podman compose up";
            }
            // builtins.mapAttrs (name: value: {
              command = "podman";
              expansion = value;
            }) {
              c = "compose";
              i = "image";
              cn = "container";
              r = "run --rm -it";
            })
        )
        (
          mkIf (cfg.aliases.docker) ({
              d = "docker";
              dcu = "docker compose up";
            }
            // builtins.mapAttrs (name: value: {
              command = "docker";
              expansion = value;
            }) {
              s = "stack";
              sp = "stack ps";
              ss = "stack services";
              sd = "stack deploy -d -c docker-compose.yml";
              sv = "service";
              c = "compose";
              i = "image";
              cn = "container";
              nl = "node ls";
              np = "node ps";
              r = "run --rm -it";
            })
        )
        (
          mkIf cfg.aliases.kubectl {
            k = "kubectl";

            kg = "kubectl get";
            kga = "kubectl get deploy,svc,pods,cm,secrets,ingresses,rs,pv,pvc,sts";
            kgd = "kubectl get deploy";
            kgs = "kubectl get services";
            kgn = "kubectl get nodes";
            kgp = "kubectl get pods";

            o = {
              expansion = "-o wide";
              command = "kubectl";
            };

            kns = "kubie ns";
            kcx = "kubie ctx";

            kd = "kubectl describe";
            kdp = "kubectl describe pods";
            kdd = "kubectl describe deployments";

            ka = "kubectl apply -f";
            ke = "kubectl explain";
          }
        )
      ];

      shellAliases = let
        tm = "test $TMUX && fish || ${lib.getExe pkgs.tmux} -L $(uuidgen)";
      in
        {
          inherit tm;

          "," = "comma -P fzf";

          ssh = "TERM=xterm-color ${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=no";

          ns = "nix-shell --command fish -p";
          cuda = "nix develop $NH_FLAKE#cuda --impure --command sh -c \"${tm}\"";
        }
        // lib.genAttrs ["ino" "rust" "rasp" "tauri" "pp"] (
          name: "nix develop $NH_FLAKE#${name} --command sh -c \"${tm}\""
        );

      plugins = [
        {
          name = "autopair";
          inherit (pkgs.fishPlugins.autopair) src;
        }
        {
          name = "done";
          src = inputs.fish-done;
        }
        {
          name = "fzf";
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
        {
          name = "sponge";
          inherit (pkgs.fishPlugins.sponge) src;
        }
      ];

      loginShellInit = with cfg.loginShell;
        if cfg.loginShell.enable
        then
          assert config.module."${wm}".enable || throw "cant use ${wm} for fish loginShell as it is not enabled";
          # fish
            ''
              if test (tty) = "/dev/tty1"
                ${
                if withIGPU
                then "set -x WLR_DRM_DEVICES /dev/dri/igpu"
                else ""
              }
                ${wm} > /dev/null
              end
            ''
        else null;

      interactiveShellInit = with colors;
      # fish
        ''
          function fish_hybrid_key_bindings
            fish_vi_key_bindings

            for mode in default insert visual
              bind --preset --erase -M $mode alt-r
              bind --preset --erase -M $mode alt-p
              bind --preset --erase -M $mode alt-v
              bind --preset --erase -M $mode alt-s
              bind --preset --erase -M $mode alt-d

              bind --preset --erase -M $mode alt-h
              bind --preset --erase -M $mode alt-j
              bind --preset --erase -M $mode alt-k
              bind --preset --erase -M $mode alt-l

              bind --preset --erase -M $mode ctrl-r
              bind --preset --erase -M $mode ctrl-h

              bind --preset --erase -M $mode \~
              bind --preset --erase -M $mode s

              bind -M $mode alt-backspace backward-kill-word
              bind -M $mode alt-f end-of-line
              bind -M $mode alt-g beginning-of-line

              bind -M $mode ctrl-l "clear; commandline -f repaint"

              bind -M $mode alt-H prevd repaint
              bind -M $mode alt-L nextd repaint

              bind -M $mode alt-o forward-bigword
              bind -M $mode alt-i backward-bigword
              bind -M $mode alt-shift-o forward-word
              bind -M $mode alt-shift-i backward-word

              bind -M $mode alt-u backward-kill-line
              bind -M $mode -m insert alt-e edit_command_buffer

              bind -M $mode alt-= fish_vi_inc
              bind -M $mode alt-minus fish_vi_dec
            end

            # -M = --mode
            # -m = --sets-mode

            bind -M visual \~ togglecase-selection

            bind -M default -m insert a forward-single-char repaint-mode

            bind -M insert            alt-enter   repaint execute
            bind -M insert            shift-enter repaint execute
            bind -M default -m insert enter       repaint execute
            bind -M visual  -m insert enter       repaint end-selection execute

            bind -M default -m insert  alt-d repaint-mode
            bind -M insert  -m default alt-d repaint-mode
            bind -M visual  -m default alt-d repaint-mode end-selection

            bind -M default           d delete-char
            bind -M default           U redo
            bind -M default     shift-d kill-word
            bind -M visual      shift-d kill-word
            bind -M visual            d kill-selection end-selection begin-selection
            bind -M visual  -m insert c kill-selection end-selection repaint-mode
            bind -M default -m insert c delete-char repaint-mode

            bind -M visual  -m insert i repaint-mode end-selection
            bind -M visual  -m insert a repaint-mode end-selection
            bind -M default -m insert i repaint-mode

            bind -M visual     \; end-selection begin-selection
            bind -M visual alt-\; swap-selection-start-stop
            bind -M visual alt-v  swap-selection-start-stop

            bind -M default -m visual x beginning-of-line begin-selection end-of-line repaint-mode
            bind -M visual            x beginning-of-line begin-selection end-of-line

            bind -M visual u       undo
            bind -M visual shift-u undo

            bind -M insert alt-h backward-char
            bind -M insert alt-l forward-char
            bind -M insert alt-k up-or-search
            bind -M insert alt-j down-or-search

            bind -M insert alt-r fzf-history-widget
            bind -M insert alt-z fzf-cd-widget
            bind -M insert alt-a _fzf_search_directory
            bind -M insert alt-x _fzf_search_git_status
            bind -M insert alt-c "__zoxide_zi; commandline -f repaint"

            bind -M visual -m default y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
            bind -M default -m insert p "fish_clipboard_paste; commandline -f repaint-mode"

            bind -M insert alt-v "fish_clipboard_paste"
          end

          set -g fish_key_bindings fish_hybrid_key_bindings

          set -g fish_cursor_end_mode exclusive
          set -g fish_cursor_selection_mode exclusive

          set -g sponge_purge_only_on_exit true
          set -g sponge_successful_exit_codes 0 130 134 137

          set -g __done_min_cmd_duration 300

          set -g fish_greeting

          set -g fish_cursor_visual block
          set -g fish_cursor_default block
          set -g fish_cursor_insert line
          set -g fish_cursor_unknown line
          set -g fish_cursor_replace_one underscore

          set -g fish_prompt_pwd_full_dirs 2

          set_color ${black} black
          set_color ${brblack} brblack
          set_color ${red} red
          set_color ${brred} brred
          set_color ${green} green
          set_color ${brgreen} brgreen
          set_color ${yellow} yellow
          set_color ${bryellow} bryellow
          set_color ${blue} blue
          set_color ${brblue} brblue
          set_color ${magenta} magenta
          set_color ${brmagenta} brmagenta
          set_color ${cyan} cyan
          set_color ${brcyan} brcyan

          # ---- syntax ----
          set -g fish_color_param white
          set -g fish_color_normal white
          set -g fish_color_valid_path white
          set -g fish_color_redirection white
          set -g fish_color_end blue
          set -g fish_color_operator blue
          set -g fish_color_warn red
          set -g fish_color_error red
          set -g fish_color_cancel red
          set -g fish_color_command green
          set -g fish_color_quote yellow
          set -g fish_color_keyword yellow
          set -g fish_color_comment brblack
          set -g fish_color_autosuggestion brblack
          set -g fish_color_selection --background=black
          set -g fish_color_search_match --background=black

          # ---- pager ----
          set -g fish_pager_color_progress black
          set -g fish_pager_color_prefix brblack
          set -g fish_pager_color_completion brblack
          set -g fish_pager_color_description brblack
          set -g fish_pager_color_selected_prefix white
          set -g fish_pager_color_selected_completion white
          set -g fish_pager_color_selected_description white
          set -g fish_pager_color_selected_background --background=""
          set -g fish_pager_color_secondary brblack
          set -g fish_pager_color_secondary_prefix brblack
          set -g fish_pager_color_secondary_completion brblack
          set -g fish_pager_color_secondary_description brblack
          set -g fish_pager_color_secondary_background brblack

          # ---- git ----
          set -g __fish_git_prompt_showdirtystate 1
          set -g __fish_git_prompt_showstashstate 1
          set -g __fish_git_prompt_showuntrackedfiles 1

          set -g __fish_git_prompt_showupstream git
          set -g __fish_git_prompt_char_stateseparator ""

          set -g __fish_git_prompt_color_branch cyan

          set -g __fish_git_prompt_color_upstream green
          set -g __fish_git_prompt_char_upstream_ahead ' ↑'
          set -g __fish_git_prompt_char_upstream_behind ' ↓'
          set -g __fish_git_prompt_char_upstream_diverged ' ↓↑'
          set -g __fish_git_prompt_char_upstream_equal ""

          set -g __fish_git_prompt_color_merging magenta

          set -g __fish_git_prompt_color_invalidstate red
          set -g __fish_git_prompt_char_invalidstate ' ✖'

          set -g __fish_git_prompt_color_dirtystate red
          set -g __fish_git_prompt_char_dirtystate ' M'

          set -g __fish_git_prompt_color_stagedstate green
          set -g __fish_git_prompt_char_stagedstate ' M'

          set -g __fish_git_prompt_color_stashstate red
          set -g __fish_git_prompt_char_stashstate ' S'

          set -g __fish_git_prompt_color_untrackedfiles red
          set -g __fish_git_prompt_char_untrackedfiles ' ?'

          set -g __fish_git_prompt_char_cleanstate ""

          printf '\e[?45l'
        '';

      functions = {
        nix_prompt =
          # fish
          ''
            if set -q IN_NIX_SHELL
              if set -q DEV_SHELL_NAME
                printf "\033[95m$DEV_SHELL_NAME\033[0m "
              else
                printf "\033[95mnix\033[0m "
              end
            end
          '';

        kubectl =
          mkIf cfg.aliases.kubectl
          # fish
          ''
            if not set -q KUBIE_ACTIVE
              printf "kubie context not set\n" >&2
              return 1
            end
            command kubectl $argv
          '';

        ssh_prompt =
          mkIf cfg.prompt.ssh
          # fish
          ''
            if set -q SSH_CONNECTION
              printf "\033[91m[SSH]\033[0m "
            end
          '';

        kube_prompt =
          mkIf cfg.prompt.kubectl
          # fish
          ''
            if not set -q KUBIE_ACTIVE
              return
            end

            set -l namespace (kubie info ns 2>/dev/null)

            if [ $status -ne 0 ];
              return
            end

            printf "\033[93m$namespace\033[0m "
          '';

        fish_mode_prompt = with colors;
        # fish
          ''
            switch $fish_bind_mode
              case insert
                printf "\033]12;#${mode_insert}\007"
              case default
                printf "\033]12;#${mode_normal}\007"
              case visual replace_one
                printf "\033]12;#${magenta}\007"
              case '*'
                printf "\033]12;#${green}\007"
            end
          '';

        fish_prompt = let
          parts = [
            (
              lib.optionalString
              cfg.prompt.ssh
              "(ssh_prompt)"
            )
            (
              lib.optionalString
              cfg.prompt.kubectl
              "(kube_prompt)"
            )
            "(nix_prompt)"
            "(fish_git_prompt \"%s \")"
            "(prompt_pwd)"
          ];
          formatString = lib.concatStrings (lib.replicate (builtins.length parts) "%s");
          argsString = lib.concatStringsSep " " parts;
        in ''
          printf "${formatString} 󰧞 " ${argsString}
        '';

        build-devshell =
          # fish
          ''
            for name in rust tauri ino rasp cuda
              nix build $NH_FLAKE#devShells.x86_64-linux.$name -o ~/.gc-root-$name
              echo $name builded
            end
          '';

        _fzf_search_directory = assert config.module.fzf.enable;
        # fish
          ''
            set -f fd_cmd ${config.programs.fzf.defaultCommand}

            set -f fzf_arguments $fzf_directory_opts
            set -f token (commandline --current-token)
            set -f expanded_token (eval echo -- $token)
            set -f unescaped_exp_token (string unescape -- $expanded_token)

            if string match --quiet -- "*/" $unescaped_exp_token && test -d "$unescaped_exp_token"
                set --append fd_cmd --base-directory=$unescaped_exp_token
                set --prepend fzf_arguments --prompt="$unescaped_exp_token> "
                set -f file_paths_selected $unescaped_exp_token($fd_cmd 2>/dev/null | _fzf_wrapper $fzf_arguments)
            else
                set --prepend fzf_arguments --query="$unescaped_exp_token"
                set -f file_paths_selected ($fd_cmd 2>/dev/null | _fzf_wrapper $fzf_arguments)
            end

            if test $status -eq 0
                commandline --current-token --replace -- "$(string escape -- $file_paths_selected)"
            end

            commandline --function repaint
          '';
      };
    };

    xdg.desktopEntries."fish" = {
      name = "fish";
      noDisplay = true;
    };
  };
}
