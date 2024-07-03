{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g prefix C-k
          # set -g default-terminal "xterm-256color"
          set -ga terminal-overrides ',xterm-256color:Tc'
          set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'

          set -g @catppuccin_flavour 'mocha'

          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_current_color "#{thm_blue}"
          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_window_default_color "#{thm_gray}"

          set -g @catppuccin_window_number_position "right"

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_middle_separator " | "
          set -g @catppuccin_window_right_separator " "

          set -g @catppuccin_status_background "default"

          set -g @catppuccin_status_modules_right "none"
        '';
      }
    ];
  };
}
