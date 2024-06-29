{ pkgs, config, ... }:
let
  tpm = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tpm";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
      sha256 = "sha256-hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
    };
  };
in {
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    shell = "${pkgs.fish}/bin/fish";
    plugins = [
      tpm
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @plugin 'catppuccin/tmux'
          set -g @plugin 'tmux-plugins/tpm'
          set -g @catppuccin_flavour 'mocha'

          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_middle_separator " | "
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_window_default_text "#{b:pane_current_path}"

          set -g @catppuccin_status_background "default"

          set -g @catppuccin_status_modules_right "directory"
          set -g @catppuccin_status_left_separator ""
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "all"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
    ];
  };
}
