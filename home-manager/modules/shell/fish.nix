{ config, pkgs, ... }: {
  home.packages = [ pkgs.eza pkgs.any-nix-shell ];
  programs.fish = {
    enable = true;
    shellAliases = {
      ls   = "${pkgs.eza}/bin/eza --icons -F -H --group-directories-first --tree -L 1";
      tree = "${pkgs.eza}/bin/eza -F -H --icons --group-directories-first --tree -L 3";
    };

    plugins = [
      #{
      #  name = "autopair";
      #  inherit (pkgs.fishPlugins.autopair) src;
      #}
      {
        name = "done";
        inherit (pkgs.fishPlugins.done) src;
      }
    ];

    interactiveShellInit = let
      c = config.colors;
    in ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      set -g fish_color_normal ${c.fg}
      set -g fish_color_command ${c.lightgreen}
      set -g fish_color_keyword -i ${c.yellow}
      set -g fish_color_quote -i ${c.yellow}
      set -g fish_color_redirection ${c.blue}
      set -g fish_color_end ${c.blue}
      set -g fish_color_error ${c.red}
      set -g fish_color_warn ${c.orange}
      set -g fish_color_param ${c.fg}
      set -g fish_color_comment -i ${c.fg-dark}
      set -g fish_color_selection --background=${c.bg-dark}
      set -g fish_color_search_match --background=${c.bg-dark}
      set -g fish_color_operator ${c.lightgreen}
      set -g fish_color_escape ${c.pink}
      set -g fish_color_autosuggestion ${c.fg-dark}
      set -g fish_color_valid_path ${c.blue}
      set -g fish_color_cancel ${c.red}

      set -g fish_pager_color_progress ${c.fg-dark}
      set -g fish_pager_color_prefix ${c.lightgreen}
      set -g fish_pager_color_completion ${c.fg}
      set -g fish_pager_color_description -i ${c.fg-dark}
      set -g fish_pager_color_selected_background --background=${c.fg-dark}

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
