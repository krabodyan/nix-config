{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.tmux;
in {
  options = {
    module.tmux = {
      enable = mkEnableOption "tmux";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.tmux];
    xdg.configFile."tmux/tmux.conf".text =
      # bash
      ''
        unbind -a -T root
        set -g mouse off

        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        set -g default-shell ${pkgs.fish}/bin/fish

        set -g prefix M-Space
        bind M-Space send-prefix

        setw -g mode-keys vi
        set -g status-keys vi

        set -g allow-passthrough all

        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

        setw -g window-status-style "bg=default,fg=black,dim"
        setw -g window-status-current-style "bg=default,fg=white,dim"
        set -g status-style "fg=default,bg=default"
        set -g pane-border-style "fg=black,bright,bg=default"
        set -g pane-active-border-style "fg=magenta,bg=default"
        set -g mode-style "bg=black,bright"
        set -g message-style "fg=white,bg=black"
        set -g copy-mode-position-style "fg=white,bg=default"
        set -g copy-mode-match-style "fg=black,bg=red"

        set -g status-interval 30
        set -g status-justify centre
        set -g status-left-length 20
        set -g status-right-length 20

        set -g status-position bottom
        set -g status-left "#[align=left]          "
        set -g status-right "#{?client_prefix,#[fg=red] NORMAL #[fg=default],}          "
        set -g status-left-length 10
        set -g status-right-length 10

        set -g cursor-style default
        set -g prompt-cursor-colour brightwhite

        set -g pane-border-indicators both
        set -g pane-border-lines simple

        set -g destroy-unattached on
        set -g detach-on-destroy off

        set -g set-clipboard external

        setw -g automatic-rename on
        setw -g pane-base-index 1
        set -g renumber-windows on
        set -g base-index 1
        set -g escape-time 0

        bind n new-window -a -c "#{pane_current_path}"
        bind M-n new-window -a -c "#{pane_current_path}"

        bind -n "M-1" select-window -t 1
        bind -n "M-2" select-window -t 2
        bind -n "M-3" select-window -t 3
        bind -n "M-4" select-window -t 4
        bind -n "M-5" select-window -t 5
        bind -n "M-6" select-window -t 6
        bind -n "M-7" select-window -t 7
        bind -n "M-9" select-window -t 8
        bind -n "M-8" select-window -t 9

        bind -n "M-Tab" last-window
        bind ":" command-prompt

        bind "h" select-pane -L
        bind "j" select-pane -D
        bind "k" select-pane -U
        bind "l" select-pane -R
        bind "M-h" select-pane -L
        bind "M-j" select-pane -D
        bind "M-k" select-pane -U
        bind "M-l" select-pane -R

        bind -n "C-n" next-layout
        bind -n "C-b" previous-layout

        # zoom
        bind -r z resize-pane -Z
        bind "w" break-pane \; move-window -r
        bind "s" command-prompt "swap-window -t %%"

        bind -r \] resize-pane -D 1
        bind -r \[ resize-pane -U 1
        bind -r i resize-pane -L 5
        bind -r o resize-pane -R 5

        bind "L" split-window -h -c "#{pane_current_path}"
        bind "H" split-window -h -c "#{pane_current_path}"
        bind "J" split-window -v -c "#{pane_current_path}"
        bind "K" split-window -v -c "#{pane_current_path}"

        bind v copy-mode

        bind -T copy-mode-vi M-d \
          if-shell -F '#{selection_active}' \
            'send-keys -X clear-selection' \
            'send-keys -X cancel'

        unbind -T copy-mode-vi "H"
        unbind -T copy-mode-vi "L"

        bind -T copy-mode-vi "K" send -X scroll-up
        bind -T copy-mode-vi "J" send -X scroll-down
        bind -T copy-mode-vi "M-f" send -X end-of-line
        bind -T copy-mode-vi "M-g" send -X start-of-line

        bind -T copy-mode-vi "v" send -X begin-selection
        bind -T copy-mode-vi "x" send -X select-line
        bind -T copy-mode-vi "r" send-keys -X rectangle-toggle
        bind -T copy-mode-vi "y" send -X copy-pipe "reattach-to-user-namespace wl-copy"
        bind -T copy-mode-vi "Y" send-keys -X copy-pipe-and-cancel "tmux paste-buffer"

        bind -T copy-mode-vi / command-prompt -T search -p "search:" { send-keys -X search-backward -- "%%" }
        bind / copy-mode \; command-prompt -T search -p "search:" { send-keys -X search-backward -- "%%" }

        bind "Q" kill-session
        bind "q" kill-window
        bind "b" set -g status
      '';
  };
}
