{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons -F -H --group-directories-first -1 -L 1";
      tree = "${pkgs.eza}/bin/eza -F -H --icons --group-directories-first --tree -L 4";
    };
    plugins = [
      {
        name = "done";
        inherit (pkgs.fishPlugins.done) src;
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

      function fish_hybrid_key_bindings
        fish_vi_key_bindings
        bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
        bind -M default U redo
        bind -M default \eh backward-word
        bind -M default \el forward-word
        bind -M visual \eh backward-word
        bind -M visual \el forward-word
        bind -M default \cc kill-whole-line
        bind -M default \cd delete-char
        bind -M insert \cd delete-char
        bind -M visual \cd forward-char
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

      function my_mode_prompt
        switch $fish_bind_mode
          case insert
            set_color ${accent}
          case default
            set_color ${red}
          case visual
            set_color ${yellow}
        end
        echo '󰧞'
        set_color normal
      end

      function fish_prompt
        printf "\033[4 q%s %s" (set_color ${accent} --bold; echo $(prompt_pwd)) (my_mode_prompt)
      end

      set -U __done_notification_duration 4000
      set -U __done_notification_urgency_level low
      set -U __done_notification_urgency_level_failure critical
    '';
  };
}
