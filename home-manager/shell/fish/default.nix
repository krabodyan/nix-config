{
  pkgs,
  theme,
  config,
  ...
}: {
  home.packages = [pkgs.nix-your-shell];

  xdg.desktopEntries."fish" = {
    name = "fish";
    noDisplay = true;
  };

  programs.fish = {
    enable = true;
    shellAliases =
      {
        flake = ''cd flake && test -n "$TMUX" || tmux'';
        ls = "${pkgs.eza}/bin/eza --icons always --group-directories-first -1";
        tree = "${pkgs.eza}/bin/eza --icons always --group-directories-first --tree -L 4";
      }
      // builtins.listToAttrs (builtins.map (name: {
        name = name;
        value = "nix develop ${config.home.sessionVariables.FLAKE}#${name}";
      }) ["tauri" "rust" "ino"]);

    plugins = [
      {
        name = "done";
        src = ./plugins/done;
      }
      {
        name = "autopair";
        inherit (pkgs.fishPlugins.autopair) src;
      }
      {
        name = "fzf";
        inherit (pkgs.fishPlugins.fzf-fish) src;
      }
    ];
    loginShellInit =
      # fish
      ''
        if test (tty) = "/dev/tty1"
          set -x WLR_DRM_DEVICES /dev/dri/igpu
          exec river
        end
      '';
    interactiveShellInit = with theme.colors; # fish
    
      ''
        function nix-shell --description "Start an interactive shell based on a Nix expression"
            nix-your-shell fish nix-shell -- $argv
        end

        function nix --description "Reproducible and declarative configuration management"
            nix-your-shell fish nix -- $argv
        end

        function fish_hybrid_key_bindings
          fish_vi_key_bindings --no-erase

          bind -M insert            alt-enter repaint-mode execute
          bind -M default -m insert enter     repaint-mode execute
          bind -M visual  -m insert enter     repaint-mode end-selection execute

          # -M = --mode
          # -m = --sets-mode

          bind -M default -m insert alt-d repaint-mode
          bind -M insert  -m default alt-d repaint-mode
          bind -M visual  -m default alt-d repaint-mode end-selection

          bind -M default -m visual d delete-char repaint-mode
          bind -M visual  -m insert c kill-selection end-selection repaint-mode
          bind -M default -m insert c begin-selection kill-selection end-selection repaint-mode

          bind -M visual  -m insert i repaint-mode end-selection
          bind -M default -m insert i repaint-mode end-selection

          bind -M visual     \; end-selection begin-selection
          bind -M visual alt-\; swap-selection-start-stop
          bind -M visual alt-v  swap-selection-start-stop

          bind -M default -m visual x beginning-of-line begin-selection end-of-line repaint-mode
          bind -M visual            x beginning-of-line begin-selection end-of-line

          for mode in default insert visual
            bind --erase -M $mode alt-r
            bind --erase -M $mode alt-l

            bind -M $mode alt-f end-of-line
            bind -M $mode alt-g beginning-of-line
          end

          bind -M insert alt-h backward-char
          bind -M insert alt-l forward-char

          bind -M insert alt-a _fzf_search_directory
          bind -M insert alt-c "__zoxide_zi; commandline -f repaint"

          bind -M visual -m default y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
          bind -M default -m insert p "fish_clipboard_paste; commandline -f repaint-mode"

          bind -M insert alt-v "fish_clipboard_paste"
        end

        set -g fish_key_bindings fish_hybrid_key_bindings

        set -g fish_prompt_pwd_dir_length 1
        set -g fish_prompt_pwd_full_dirs 1

        set fish_greeting

        set fish_cursor_visual block
        set fish_cursor_default block
        set fish_cursor_insert block

        function fish_mode_prompt
        end

        # function update_cwd_osc --on-variable PWD --description 'Notify terminals when \$PWD changes'
        #     if status --is-command-substitution || set -q INSIDE_EMACS
        #         return
        #     end
        #     printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
        # end

        # update_cwd_osc

        function fish_prompt
          switch $fish_bind_mode
            case insert
              printf "\033]12;#${mode_insert}\007"
              set_color ${fg}
            case default
              printf "\033]12;#${mode_normal}\007"
              set_color ${mode_normal}
            case visual
              printf "\033]12;#${mode_select}\007"
              set_color ${mode_select}
            case '*'
              printf "\033]12;#${green}\007"
              set_color ${green}
          end

          if set -q IN_NIX_SHELL
            if set -q DEV_SHELL_NAME
              printf "\033[36m$DEV_SHELL_NAME\033[0m %s 󰧞 " (prompt_pwd)
            else
              printf "\033[36mnix-shell\033[0m %s 󰧞 " (prompt_pwd)
            end
          else
            printf "%s 󰧞 " (prompt_pwd)
          end

          set_color normal
        end

        set -g fish_color_normal ${fg}
        set -g fish_color_command ${green}
        set -g fish_color_keyword -i ${yellow}
        set -g fish_color_quote ${yellow}
        set -g fish_color_redirection ${blue}
        set -g fish_color_end ${blue}
        set -g fish_color_error ${red}
        set -g fish_color_warn ${orange}
        set -g fish_color_param ${fg}
        set -g fish_color_comment -i ${fg-dark}
        set -g fish_color_selection --background=${surface2}
        set -g fish_color_search_match --background=${fg-dark}
        set -g fish_color_operator ${green}
        set -g fish_color_autosuggestion ${fg-dark}
        set -g fish_color_valid_path ${fg}
        set -g fish_color_cancel ${red}

        set -g fish_pager_color_secondary ${red}
        set -g fish_pager_color_progress ${red}
        set -g fish_pager_color_prefix ${fg-dark}
        set -g fish_pager_color_completion ${fg-dark}
        set -g fish_pager_color_description -i ${fg-dark}
        set -g fish_pager_color_selected_prefix ${fg}
        set -g fish_pager_color_selected_completion ${fg}
        set -g fish_pager_color_selected_description -i ${fg}
        set -g fish_pager_color_selected_background ${bg}

        printf '\e[?45l'
      '';

    functions._fzf_search_directory =
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
}
