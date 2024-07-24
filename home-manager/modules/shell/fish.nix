{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    eza
    any-nix-shell
  ];
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

      bind \e\[C true
      bind \el forward-char
      bind \e\[D true
      bind \eh backward-char
      bind \e\[A true
      bind \ek up-or-search
      bind \e\[B true
      bind \ej down-or-search

      bind --erase --preset \ef
      bind --erase --preset \cf
      bind --erase --preset \ed

      # alt + d/f
      bind \ed forward-char
      bind \cf forward-word

      bind --erase --preset \f
      bind --erase --preset \b

      # alt + left right
      bind \f nextd-or-forward-word
      bind \b prevd-or-backward-word

      # ctrl + j
      bind --erase --preset \n

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
      set -g fish_color_selection --background=${bg-dark}
      set -g fish_color_search_match --background=${fg-dark}
      set -g fish_color_operator ${green}
      set -g fish_color_autosuggestion ${fg-dark}
      set -g fish_color_valid_path ${accent} --bold
      set -g fish_color_cancel ${red}

      set -g fish_pager_color_progress ${fg-dark}
      set -g fish_pager_color_prefix ${green}
      set -g fish_pager_color_completion ${fg}
      set -g fish_pager_color_description -i ${fg-dark}
      set -g fish_pager_color_selected_background --background=${fg-dark}

      set -g fish_prompt_pwd_dir_length 3
      set -g fish_prompt_pwd_full_dirs 0
      set fish_greeting

      function fish_prompt
        printf "\033[1;34m\033[4 q%s 󰧞 \033[0m" (prompt_pwd)
      end

      set -U __done_notification_duration 4000
      set -U __done_notification_urgency_level low
      set -U __done_notification_urgency_level_failure critical
    '';
  };
}
