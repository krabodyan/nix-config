{ theme, pkgs, ... }: {
  home.packages = with pkgs; [ nix-your-shell ];
  xdg.desktopEntries."fish" = {
    name = "fish";
    noDisplay = true;
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      flake = "cd flake && pidof zellij || zellij";
      ls = "${pkgs.eza}/bin/eza --icons always --group-directories-first -1";
      tree =
        "${pkgs.eza}/bin/eza --icons always --group-directories-first --tree -L 4";
      c = "__zoxide_zi";
    } // builtins.listToAttrs (builtins.map (name: {
      name = name;
      value = "nix develop $FLAKE#${name}";
    }) [ "tauri" "rust" "ino" ]);

    functions = {
      _fzf_search_directory = # fish
        ''
          set -f fd_cmd ${pkgs.fd}/bin/fd
          set -f --append fd_cmd $fzf_fd_opts

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
    plugins = let
      zoxide = pkgs.fishPlugins.buildFishPlugin rec {
        pname = "zoxide.fish";
        version = "1.0";

        src = pkgs.fetchFromGitHub {
          owner = "Susensio";
          repo = pname;
          rev = "b1aebcc484ea500a2acbfea85a7dcddc8a25f198";
          sha256 = "sha256-9hqq4hjsXhmDr06zdx+TokpZeMpzn0tNKtb8v1ghZsI=";
        };

        meta = {
          description = "zoxide plugin fish";
          homepage = "https://github.com/kidonng/zoxide.fish";
        };
      };
    in [
      {
        name = "done";
        src = ./plugins/done;
      }
      {
        name = "zoxide.fish";
        inherit (zoxide) src;
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
    loginShellInit = # fish
      ''
        if test (tty) = "/dev/tty1"
          set -x WLR_DRM_DEVICES /dev/dri/igpu
          exec river
        end
      '';
    interactiveShellInit = with theme; # fish
      ''
        function nix-shell --description "Start an interactive shell based on a Nix expression"
            nix-your-shell fish nix-shell -- $argv
        end

        function nix --description "Reproducible and declarative configuration management"
            nix-your-shell fish nix -- $argv
        end

        function fish_hybrid_key_bindings
          fish_vi_key_bindings --no-erase
          
          bind --mode default --sets-mode insert \ed "commandline -f repaint-mode"
          bind --mode insert --sets-mode default \ed "commandline -f repaint-mode"
          bind --mode visual --sets-mode default \ed "commandline -f repaint-mode; commandline -f end-selection"

          bind --mode insert \ec __zoxide_zi
          
          bind --mode default --sets-mode default d "set fish_bind_mode visual; commandline -f delete-char"
          bind --mode default --sets-mode insert c "set fish_bind_mode visual; commandline -f delete-char; commandline -f repaint-mode"

          bind --mode visual --sets-mode insert i "commandline -f repaint-mode; commandline -f end-selection"
          bind --mode default --sets-mode insert i "commandline -f repaint-mode; commandline -f end-selection"

          bind --mode visual \; "commandline -f end-selection; commandline -f begin-selection"
          bind --mode visual \ev swap-selection-start-stop
          bind --mode visual \e\; swap-selection-start-stop

          bind --mode default --sets-mode visual x "commandline -f beginning-of-line; commandline -f begin-selection; commandline -f end-of-line; commandline -f repaint-mode"
          bind --mode visual x "commandline -f beginning-of-line; commandline -f begin-selection; commandline -f end-of-line"

          for mode in default insert visual
            bind --erase --preset --mode $mode \e\r
            bind --erase --preset --mode $mode \el

            bind --mode $mode \ef end-of-line
            bind --mode $mode \eg beginning-of-line
          end

          bind --mode insert \eh backward-char
          bind --mode insert \el forward-char
          
          bind --mode insert \ea _fzf_search_directory

          bind --mode visual -m default y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
          bind --mode default -m insert p "fish_clipboard_paste; commandline -f repaint-mode"
        end

        set -g fish_key_bindings fish_hybrid_key_bindings

        set --universal zoxide_cmd cd

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

        set -g fish_prompt_pwd_dir_length 1
        set -g fish_prompt_pwd_full_dirs 1

        set fish_greeting

        function fish_mode_prompt
        end

        function update_cwd_osc --on-variable PWD --description 'Notify terminals when \$PWD changes'
            if status --is-command-substitution || set -q INSIDE_EMACS
                return
            end
            printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
        end

        update_cwd_osc 

        function fish_prompt
          switch $fish_bind_mode
            # set_color --bold
            case insert
              printf "\033]12;#${fg}\007"
              set_color ${fg}
              printf "\033[4 q"
            case default
              printf "\033]12;#${mode_normal}\007"
              set_color ${mode_normal}
              printf "\033[2 q"
            case visual
              printf "\033]12;#${mode_select}\007"
              set_color ${mode_select}
              printf "\033[2 q"
            case '*'
              printf "\033]12;#${green}\007"
              set_color ${green}
              printf "\033[4 q"
          end
          if test -z "$IN_NIX_SHELL"
            printf "%s 󰧞 " (prompt_pwd) 
          else
            set -q DEV_SHELL_NAME; or set -l DEV_SHELL_NAME "nix-shell"
            printf "\033[36m$DEV_SHELL_NAME\033[0m %s 󰧞 " (prompt_pwd)
          end
          set_color normal
        end

        set -U __done_min_cmd_duration 5000

        set -g fzf_fd_opts --color never --type file 

        printf '\e[?45l'
      '';
  };
}
