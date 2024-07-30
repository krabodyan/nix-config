{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''
      set -g prefix C-k
      set -g status-position top
      set -g update-environment "DISPLAY WAYLAND_DISPLAY SWAYSOCK SSH_AUTH_SOCK"
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*:RGB"
      set -ga terminal-overrides ',*:Ss=\033[4 q:Se=\033[4 q'
    '';
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'

          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_current_color "#{thm_blue}"
          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_window_default_color "#{thm_gray}"

          set -g @catppuccin_window_number_position "left"

          set -g @catppuccin_window_left_separator "█"
          set -g @catppuccin_window_middle_separator " "
          set -g @catppuccin_window_right_separator "█"

          set -g @catppuccin_status_background "default"

          set -g @catppuccin_status_modules_right "none"
        '';
      }
    ];
  };
}
