{ theme, helpers, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "M-Space";
    disableConfirmationPrompt = true;
    escapeTime = 1000;
    keyMode = "vi";
    mouse = false;
    resizeAmount = 15;
    shell = "fish";
    extraConfig = ''
      unbind-key -a
              
      set-option -g status-style "fg=default,bg=default"

      set-window-option -g window-status-current-style "fg=red,bg=default"
      set-option -g pane-border-style "fg=colour0,bg=default"
      set-option -g pane-active-border-style "fg=cyan,bg=default"
      set -g status-interval 30
      set -g status-justify centre
      set -g status-left-length 40
      set -g status-right-length 140
      set-option -g status-position bottom
      set -g status-left \'\' set - g status-right \'\'

      set-option -g set-clipboard external
      set -g status-keys vi
      set -g base-index 1
      setw -g pane-base-index 1
      set -s escape-time 0
      set -g renumber-windows on


      set -g prefix M-Space
      bind M-Space send-prefix

      bind M switch-client -t'{marked}'
      # todo rebind mark

      bind n new-window -c "#{pane_current_path}"

      bind s break-pane
      bind-key c command-prompt -p "join pane from:"  "join-pane -s '%%'"
      bind-key b command-prompt -p "send pane to:"  "join-pane -t '%%'"

      # bind j choose-window 'join-pane -h -s "%%"'
      # bind J choose-window 'join-pane -s "%%"'

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      bind -r M-h select-pane -L
      bind -r M-j select-pane -D
      bind -r M-k select-pane -U
      bind -r M-l select-pane -R

      # bind -r "" swap-window -d -t -1
      # bind -r "" swap-window -d -t +1

      bind -r C-j resize-pane -D 15
      bind -r C-k resize-pane -U 15
      bind -r C-h resize-pane -L 15
      bind -r C-l resize-pane -R 15

      bind-key 'L' split-window -h -c "#{pane_current_path}"
      bind-key 'H' split-window -h -c "#{pane_current_path}"
      bind-key 'J' split-window -v -c "#{pane_current_path}"
      bind-key 'K' split-window -v -c "#{pane_current_path}"

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'r' send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "reattach-to-user-namespace wl-copy"
      bind-key -T copy-mode-vi 'Y' send-keys -X copy-pipe-and-cancel "tmux paste-buffer"
    '';
  };
}
