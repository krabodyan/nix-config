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
      enable = mkEnableOption "enable fish";
      loginShell = {
        enable = mkEnableOption "enable fish loginshell";
        wm = mkOption {
          type = lib.types.str;
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

      shellAbbrs =
        {
          # ------- NIX -------
          nr = {
            expansion = "nix run nixpkgs#%";
            setCursor = true;
          };

          # ------- GIT -------
          g = "git";
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
          gs = "git status";
          gr = "git restore";
          grs = "git restore --staged";
          ga = "git add";
          gg = "git graph -10";

          # ----- DOCKER -----
          d = "docker";
        }
        // builtins.mapAttrs (name: value: {
          command = "docker";
          expansion = value;
        }) {
          s = "stack";
          sp = "stack ps";
          ss = "stack services";
          sd = "stack deploy -c docker-compose-yml";
          sv = "service";
          i = "image";
          c = "container";
          n = "node";
          nl = "node ls";
          np = "node ps";
          r = "run --rm -it";
        };

      shellAliases = let
        tm = "${pkgs.tmux}/bin/tmux -L $(uuidgen)";
      in
        {
          inherit tm;
          "," = "comma -P fzf";
          ns = "nix-shell --command fish -p";
        }
        // lib.genAttrs ["ino" "rust" "rasp" "tauri"] (
          name: "nix develop $FLAKE#${name} --command ${tm}"
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

      loginShellInit =
        if cfg.loginShell.enable
        then # fish
          ''
            if test (tty) = "/dev/tty1"
              ${
              if cfg.loginShell.withIGPU
              then "set -x WLR_DRM_DEVICES /dev/dri/igpu"
              else ""
            }
              exec ${cfg.loginShell.wm}
            end
          ''
        else null;

      interactiveShellInit = with colors; # fish

        ''
          function fish_hybrid_key_bindings
            fish_vi_key_bindings

            for mode in default insert visual
              bind --preset --erase -M $mode alt-r
              bind --preset --erase -M $mode alt-v
              bind --preset --erase -M $mode alt-s
              bind --preset --erase -M $mode alt-d

              bind --preset --erase -M $mode alt-h
              bind --preset --erase -M $mode alt-j
              bind --preset --erase -M $mode alt-k
              bind --preset --erase -M $mode alt-l

              bind --preset --erase -M $mode ctrl-r
              bind --preset --erase -M $mode ctrl-h

              bind -M $mode alt-f end-of-line
              bind -M $mode alt-g beginning-of-line

              bind -M $mode ctrl-l "clear; commandline -f repaint"

              bind -M $mode alt-H prevd repaint-mode
              bind -M $mode alt-L nextd repaint-mode

              bind -M $mode alt-o forward-bigword
              bind -M $mode alt-i backward-bigword
              bind -M $mode alt-shift-o forward-word
              bind -M $mode alt-shift-i backward-word

              bind -M $mode alt-u backward-kill-line
            end

            bind -M insert            alt-enter   repaint-mode execute
            bind -M insert            shift-enter repaint-mode execute
            bind -M default -m insert enter       repaint-mode execute
            bind -M visual  -m insert enter       repaint-mode end-selection execute

            # -M = --mode
            # -m = --sets-mode

            bind -M default -m insert  alt-d repaint-mode
            bind -M insert  -m default alt-d repaint-mode
            bind -M visual  -m default alt-d repaint-mode end-selection

            bind -M default           d delete-char
            bind -M default           U redo
            bind -M visual            d kill-selection end-selection begin-selection
            bind -M visual  -m insert c kill-selection end-selection repaint-mode
            bind -M default -m insert c delete-char repaint-mode

            bind -M visual  -m insert i repaint-mode end-selection
            bind -M default -m insert i repaint-mode end-selection

            bind -M visual     \; end-selection begin-selection
            bind -M visual alt-\; swap-selection-start-stop
            bind -M visual alt-v  swap-selection-start-stop

            bind -M default -m visual x beginning-of-line begin-selection end-of-line repaint-mode
            bind -M visual            x beginning-of-line begin-selection end-of-line

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
          set -g fish_greeting
          set -g fish_cursor_visual block
          set -g fish_cursor_default block
          set -g fish_cursor_insert line
          set -g fish_cursor_replace_one underscore

          set sponge_purge_only_on_exit true

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

          printf '\e[?45l'
        '';

      functions = {
        build-devshell =
          # fish
          ''
            for name in rust tauri ino rasp
              nix build $FLAKE#devShells.x86_64-linux.$name -o ~/.gc-root-$name
              echo $name builded
            end
          '';
        starship_precmd_user_func = with colors; ''
          switch $fish_bind_mode
            case insert
              printf "\033]12;#${mode_insert}\007"
              set_color normal
            case default
              printf "\033]12;#${mode_normal}\007"
              set_color ${mode_normal}
            case visual replace_one
              printf "\033]12;#${mode_select}\007"
              set_color ${mode_select}
            case '*'
              printf "\033]12;#${green}\007"
              set_color green
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
