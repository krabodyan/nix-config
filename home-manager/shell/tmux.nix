{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    extraConfig = with config.colors; ''
      set -g prefix C-k
      set -g status-position top
      set -g update-environment "DISPLAY WAYLAND_DISPLAY SWAYSOCK SSH_AUTH_SOCK"
      set -g default-terminal "tmux-256color"

      set -ga terminal-overrides ",*:RGB"
      # set -ga terminal-overrides ',*:Ss=\033[4 q:Se=\033[4 q'
      set -g status-interval 1
      set -g pane-active-border-style fg='#${fg}'
      set -g pane-border-style fg='#${fg-dark}'
      set -g status-justify centre
      set -g base-index 1
      setw -g pane-base-index 1
      set-option -g status-style bg=default
      set -g status-fg '#${fg}'
      set -g status-left ""
      set -g status-right ""
      set -g window-status-current-format "#[fg=#${blue}]#I:#W  "
      set -g window-status-format "#[fg=#${fg-dark}]#I:#W  "
    '';
  };
}
