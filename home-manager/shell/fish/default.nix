{ theme, pkgs, ... }: {
  home.packages = with pkgs; [ nix-your-shell ];
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons always --group-directories-first -1";
      tree =
        "${pkgs.eza}/bin/eza --icons always --group-directories-first --tree -L 4";
      c = "__zoxide_zi";
    };
    functions = {
      _fzf_search_directory = ''
        set -f fd_cmd ${pkgs.fd}/bin/fd
        set -f --append fd_cmd $fzf_fd_opts

        set -f fzf_arguments $fzf_directory_opts
        set -f token (commandline --current-token)
        set -f expanded_token (eval echo -- $token)
        set -f unescaped_exp_token (string unescape -- $expanded_token)

        if string match --quiet -- "*/" $unescaped_exp_token && test -d "$unescaped_exp_token"
            set --append fd_cmd --base-directory=$unescaped_exp_token
            set --prepend fzf_arguments --prompt="$unescaped_exp_token> " --preview="_fzf_preview_file $expanded_token{}"
            set -f file_paths_selected $unescaped_exp_token($fd_cmd 2>/dev/null | _fzf_wrapper $fzf_arguments)
        else
            set --prepend fzf_arguments --query="$unescaped_exp_token" --preview='_fzf_preview_file {}'
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
        name = "fzf";
        inherit (pkgs.fishPlugins.fzf-fish) src;
      }
    ];
    loginShellInit = ''
      if test (tty) = "/dev/tty1"
        set -x WLR_DRM_DEVICES /dev/dri/igpu
        exec river
      end
    '';
    interactiveShellInit = with theme; ''
      function nix-shell --description "Start an interactive shell based on a Nix expression"
          nix-your-shell fish nix-shell -- $argv
      end

      function nix --description "Reproducible and declarative configuration management"
          nix-your-shell fish nix -- $argv
      end
      set --universal zoxide_cmd cd
      bind -M insert \ef end-of-line
      bind -M default \ef end-of-line
      bind -M insert \f 'clear; commandline -f repaint'
      bind -M default \f 'clear; commandline -f repaint'
      bind -M insert \ea beginning-of-line
      bind -M insert \cf _fzf_search_directory

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
      set -g fish_color_selection ${fg-dark} --background=${fg}
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
            set_color ${fg}
          case default
            set_color ${red}
          case visual
            set_color ${magenta}
          case '*'
            set_color ${green}
        end
        if test -z "$IN_NIX_SHELL"
          printf "\033[4 q%s 󰧞 " (prompt_pwd) 
        else
          set -q DEV_SHELL_NAME; or set -l DEV_SHELL_NAME "nix-shell"
          printf "\033[36m$DEV_SHELL_NAME\033[0m\033[4 q %s 󰧞 " (prompt_pwd)
        end
        set_color normal
      end

      set -U __done_min_cmd_duration 5000

      set -g fzf_fd_opts --color never --type file 

      printf '\e[?45l'
    '';
  };
}
