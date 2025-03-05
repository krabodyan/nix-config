{ theme, pkgs, ... }: {
  home.packages = [ pkgs.tmux ];
  xdg.configFile."tmux/tmux.conf".text = with theme.colorsHex; # bash
    ''
      unbind -a

      set -g default-command ${pkgs.fish}/bin/fish
      set -g default-shell ${pkgs.fish}/bin/fish     

      set -g prefix M-Space
      bind M-Space send-prefix

      setw -g mode-keys vi
      set -g status-keys vi

      set-window-option -g automatic-rename on
      setw -g automatic-rename

      set -g allow-passthrough all

      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
              
      set-option -g status-style "fg=default,bg=default"
      set-window-option -g window-status-style "bg=default,fg=${overlay0}"
      set-window-option -g window-status-current-style "bg=default,fg=${subtext0}"
      set-option -g pane-border-style "fg=${surface2},bg=default"
      set-option -g pane-active-border-style "fg=${select},bg=default"
      set-option -g mode-style "fg=default,bg=${surface2}"
      set-option -g message-style "fg=default,bg=${surface0}"

      set -g status-interval 30
      set -g status-justify left
      set -g status-left-length 100
      set -g status-right-length 50
      set-option -g status-position bottom
      set-option -g status-left ""
      set-option -g status-right '#{?client_prefix,#[fg=${red}]NORMAL#[fg=default],}'

      set-option -g detach-on-destroy on
      set-option -g set-clipboard external
      set -g base-index 1
      setw -g pane-base-index 1
      set -s escape-time 0
      set -g renumber-windows on

      # bind M switch-client -t '{marked}'

      bind n new-window -c "#{pane_current_path}"
      bind M-n new-window -c "#{pane_current_path}"

      bind s break-pane

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      bind -r M-h select-pane -L
      bind -r M-j select-pane -D
      bind -r M-k select-pane -U
      bind -r M-l select-pane -R

      # bind -n M-y swap-pane -t -1
      # bind -n M-u swap-pane -t +1
      bind -n M-n next-layout
      bind -n M-b previous-layout

      bind -r \] resize-pane -D 1
      bind -r \[ resize-pane -U 1
      bind -r i resize-pane -L 5
      bind -r o resize-pane -R 5

      bind 'L' split-window -h -c "#{pane_current_path}"
      bind 'H' split-window -h -c "#{pane_current_path}"
      bind 'J' split-window -v -c "#{pane_current_path}"
      bind 'K' split-window -v -c "#{pane_current_path}"

      bind v copy-mode
      bind -T copy-mode-vi M-d send-keys -X cancel
      unbind -T copy-mode-vi 'H'
      unbind -T copy-mode-vi 'L'

      bind -T copy-mode-vi 'K' send -X scroll-up
      bind -T copy-mode-vi 'J' send -X scroll-down
      bind -T copy-mode-vi 'M-f' send -X end-of-line
      bind -T copy-mode-vi 'M-g' send -X start-of-line

      bind -T copy-mode-vi 'v' send -X begin-selection
      bind -T copy-mode-vi 'r' send-keys -X rectangle-toggle
      bind -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "reattach-to-user-namespace wl-copy"
      bind -T copy-mode-vi 'Y' send-keys -X copy-pipe-and-cancel "tmux paste-buffer"
    '';
}
