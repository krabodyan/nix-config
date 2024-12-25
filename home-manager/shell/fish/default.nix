{ config, pkgs, ... }: {
  home.packages = [ pkgs.zoxide ];
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons always --group-directories-first -1";
      tree =
        "${pkgs.eza}/bin/eza --icons always --group-directories-first --tree -L 4";
      j = "__zoxide_zi";
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
        set -x WLR_DRM_DEVICES /dev/dri/card1
        exec dbus-run-session river
      end
    '';
    interactiveShellInit = with config.colors; ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      set --universal zoxide_cmd cd
      bind -M insert \ef end-of-line
      bind -M default \ef end-of-line
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

      set -g fish_prompt_pwd_dir_length 3
      set -g fish_prompt_pwd_full_dirs 0

      set fish_greeting

      function fish_mode_prompt
      end

      function fish_prompt
        switch $fish_bind_mode
          case insert
            set_color --bold ${fg}
          case default
            set_color --bold ${red}
          case visual
            set_color --bold ${magenta}
          case '*'
            set_color --bold ${green}
        end
        printf "\033[4 q%s 󰧞 " (prompt_pwd) 
        set_color normal
      end

      # set -U __done_sound_command "pw-cat -p ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga"
      set -U __done_min_cmd_duration 5000

      set -g fzf_fd_opts --color never --type file 

      printf '\e[?45l'
    '';
  };
}
