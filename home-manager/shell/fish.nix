{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons -F -H --group-directories-first -1 -L 1";
      tree = "${pkgs.eza}/bin/eza -F -H --icons --group-directories-first --tree -L 4";
      ci = "__zoxide_zi";
    };
    plugins = [
      {
        name = "done";
        inherit (pkgs.fishPlugins.done) src;
      }
      {
        name = "fzf";
        inherit (pkgs.fishPlugins.fzf-fish) src;
      }
    ];
    loginShellInit = ''
      if test (tty) = "/dev/tty1"
        if test -e /dev/dri/card0 || test -e /dev/dri/card2
          set -x WLR_DRM_DEVICES /dev/dri/card1
          exec dbus-run-session sway --unsupported-gpu > /dev/null 2>&1
        else
          exec dbus-run-session sway > /dev/null 2>&1
        end
      end
    '';
    interactiveShellInit = with config.colors; ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      ${pkgs.zoxide}/bin/zoxide init --cmd cd fish | source

      function fish_hybrid_key_bindings
        fish_vi_key_bindings
        bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
        bind -M default U redo
        bind -M default \eh backward-word
        bind -M default \el forward-word
        bind -M visual \eh backward-word
        bind -M visual \el forward-word
        bind -M default \cc kill-whole-line
        bind -M insert \ef _fzf_search_directory
      end

      set -g fish_key_bindings fish_hybrid_key_bindings

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
      set -g fish_color_selection --background=${fg-dark}
      set -g fish_color_search_match --background=${fg-dark}
      set -g fish_color_operator ${green}
      set -g fish_color_autosuggestion ${fg-dark}
      set -g fish_color_valid_path ${blue} --bold
      set -g fish_color_cancel ${red}

      set -g fish_pager_color_progress ${fg-dark}
      set -g fish_pager_color_prefix ${green}
      set -g fish_pager_color_completion ${fg}
      set -g fish_pager_color_description -i ${fg-dark}
      set -g fish_pager_color_selected_background --background=${fg-dark}

      set -g fish_prompt_pwd_dir_length 3
      set -g fish_prompt_pwd_full_dirs 0

      set fish_greeting

      function fish_mode_prompt
      end

      function fish_prompt
        switch $fish_bind_mode
          case insert
            set_color --bold ${accent}
          case default
            set_color --bold ${red}
          case visual
            set_color --bold ${yellow}
          case replace_one
            set_color --bold ${pink}
          case replace
            set_color --bold ${magenta}
          case '*'
            set_color --bold ${bg}
        end
        printf "\033[4 q%s 󰧞 " (prompt_pwd) 
        set_color normal
      end

      set -U __done_notification_duration 4000
      set -U __done_notification_urgency_level low
      set -U __done_notification_urgency_level_failure critical

      set -g fzf_fd_opts --color never --type file 

      function _fzf_search_directory --description "Search the current directory. Replace the current token with the selected file paths."
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
            commandline --current-token --replace -- (string escape -- $file_paths_selected | string join ' ')
        end

        commandline --function repaint
      end
    '';
  };
}
