{
  lib,
  config,
  pkgs,
  colors,
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
    home.packages = [pkgs.nix-your-shell];

    programs.fish = {
      enable = true;

      shellAliases = {
        ino = "nix develop $FLAKE#ino";
        rust = "nix develop $FLAKE#rust";
        tauri = "nix develop $FLAKE#tauri";
      };

      plugins = let
        done = pkgs.fishPlugins.buildFishPlugin rec {
          pname = "fish-done-osc99";
          version = "1.0";
          src = pkgs.fetchFromGitHub {
            owner = "krabodyan";
            repo = pname;
            rev = "00493a676621befaeafeabae6d0c8aacaf06f32a";
            sha256 = "sha256-J0MtyqGKkIv/e0K/f/ZGHOgfofXgamvQ+qCpg4PFaE8=";
          };
        };
      in [
        {
          name = "autopair";
          inherit (pkgs.fishPlugins.autopair) src;
        }
        {
          name = "done";
          inherit (done) src;
        }
        {
          name = "fzf";
          inherit (pkgs.fishPlugins.fzf-fish) src;
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
          function nix-shell --description "Start an interactive shell based on a Nix expression"
              nix-your-shell fish nix-shell -- $argv
          end

          function nix --description "Reproducible and declarative configuration management"
              nix-your-shell fish nix -- $argv
          end

          function fish_hybrid_key_bindings
            fish_vi_key_bindings

            for mode in default insert visual
              bind --preset --erase -M $mode alt-r
              bind --preset --erase -M $mode alt-v

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

              bind -M $mode alt-i forward-word
              bind -M $mode alt-o backward-word
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

          # set -g fish_prompt_pwd_dir_length 1
          set -g fish_prompt_pwd_full_dirs 2

          set fish_greeting

          set fish_cursor_visual block
          set fish_cursor_default block
          set fish_cursor_insert line
          set fish_cursor_replace_one underscore

          function fish_mode_prompt
          end

          function fish_prompt
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
                printf "\033]12;#green\007"
                set_color green
            end

            if set -q IN_NIX_SHELL
              if set -q DEV_SHELL_NAME
                printf "\033[36m$DEV_SHELL_NAME\033[0m %s%s 󰧞 " (prompt_pwd) (fish_git_prompt)
              else
                printf "\033[36mnix-shell\033[0m %s%s 󰧞 " (prompt_pwd) (fish_git_prompt)
              end
            else
              printf "%s%s 󰧞 " (prompt_pwd) (fish_git_prompt)
            end

            set_color normal
          end

          set -g fish_color_normal normal
          set -g fish_color_command green
          set -g fish_color_keyword -i yellow
          set -g fish_color_quote yellow
          set -g fish_color_redirection normal
          set -g fish_color_end normal
          set -g fish_color_error red
          set -g fish_color_warn ${orange}
          set -g fish_color_param normal
          set -g fish_color_comment ${fg-dark}
          set -g fish_color_selection --background=${surface2}
          set -g fish_color_search_match --background=${fg-dark}
          set -g fish_color_operator normal
          set -g fish_color_autosuggestion brblack
          set -g fish_color_valid_path normal
          set -g fish_color_cancel red

          set -g fish_pager_color_progress ${overlay0}
          set -g fish_pager_color_prefix ${fg-dark}
          set -g fish_pager_color_completion ${fg-dark}
          set -g fish_pager_color_description ${fg-dark}
          set -g fish_pager_color_selected_prefix normal
          set -g fish_pager_color_selected_completion normal
          set -g fish_pager_color_selected_description normal
          set -g fish_pager_color_selected_background ${bg}
          set -g fish_pager_color_secondary ${overlay0}
          set -g fish_pager_color_secondary_prefix ${fg-dark}
          set -g fish_pager_color_secondary_completion ${fg-dark}
          set -g fish_pager_color_secondary_description ${fg-dark}
          set -g fish_pager_color_secondary_background ${fg-dark}

          set -g __fish_git_prompt_show_informative_status 1
          set -g __fish_git_prompt_showdirtystate 1
          set -g __fish_git_prompt_showstashstate 1
          set -g __fish_git_prompt_showuntrackedfiles 1
          set -g __fish_git_prompt_show_informative_status 0
          set -g __fish_git_prompt_char_stateseparator ""

          set -g __fish_git_prompt_color_branch ${sky}
          set -g __fish_git_prompt_color_prefix ${overlay1}
          set -g __fish_git_prompt_color_suffix ${overlay1}

          set -g __fish_git_prompt_showupstream auto
          set -g __fish_git_prompt_color_upstream green
          set -g __fish_git_prompt_char_upstream_ahead ' ↑'
          set -g __fish_git_prompt_char_upstream_behind ' ↓'
          set -g __fish_git_prompt_char_upstream_diverged ' ↓↑'
          set -g __fish_git_prompt_char_upstream_equal ""

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
        build-devshell =
          # fish
          ''
            for name in rust tauri ino
              nix build $FLAKE#devShells.x86_64-linux.$name -o ~/.gc-root-$name
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
