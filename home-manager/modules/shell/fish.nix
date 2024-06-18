{ config, pkgs, ... }: {
  home.packages = [ pkgs.eza pkgs.any-nix-shell ];
  programs.fish = {
    enable = true;
    shellAliases = {
      ls   = "${pkgs.eza}/bin/eza --icons -F -H --group-directories-first --tree -L 1";
      tree = "${pkgs.eza}/bin/eza -F -H --icons --group-directories-first --tree -L 3";
    };

    plugins = [
      {
        name = "autopair";
        inherit (pkgs.fishPlugins.autopair) src;
      }
      {
        name = "done";
        inherit (pkgs.fishPlugins.done) src;
      }
    ];

    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

      set -l comment ${config.colors.fg-dark}
      set -l foreground ${config.colors.fg-bright}
      set -l selection ${config.colors.fg-dark}
      set -l red ${config.colors.red}
      set -l orange ${config.colors.orange}
      set -l yellow ${config.colors.yellow}
      set -l green ${config.colors.green}
      set -l purple ${config.colors.magenta}
      set -l cyan ${config.colors.cyan}
      set -l pink ${config.colors.pink}
      set -l blue ${config.colors.blue}
      set -l lightgreen ${config.colors.lightgreen}

      set -g fish_color_normal $foreground
      set -g fish_color_command $green
      set -g fish_color_keyword -i $yellow
      set -g fish_color_quote -i $yellow
      set -g fish_color_redirection $orange
      set -g fish_color_end $orange
      set -g fish_color_error $red
      set -g fish_color_warn $orange
      set -g fish_color_param $foreground
      set -g fish_color_comment -i $comment
      set -g fish_color_selection --background=$selection
      set -g fish_color_search_match --background=$selection
      set -g fish_color_operator $green
      set -g fish_color_escape $pink
      set -g fish_color_autosuggestion $comment
      set -g fish_color_valid_path $blue
      set -g fish_color_cancel $red

      set -g fish_pager_color_progress $comment
      set -g fish_pager_color_prefix $green
      set -g fish_pager_color_completion $foreground
      set -g fish_pager_color_description -i $lightgreen
      set -g fish_pager_color_selected_background --background=$selection

      set -g fish_prompt_pwd_dir_length 3
      set -g fish_prompt_pwd_full_dirs 0
      set fish_greeting

      function fish_prompt
        string join "" -- (prompt_pwd) " ➜ "
      end

      set -U __done_notification_duration 4000
      set -U __done_notification_urgency_level low
      set -U __done_notification_urgency_level_failure critical
    '';
  };
}
