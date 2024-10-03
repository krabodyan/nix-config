{ config, ... }:
{
  programs.zellij = {
    enable = true;
  };
  xdg.configFile."zellij/config.kdl".text = with config.colors; ''
    themes {
      default {
        bg "#${bg}"
        fg "#${fg}"
        red "#${red}"
        green "#${green}"
        blue "#${cyan}"
        yellow "#${yellow}"
        magenta "#${magenta}"
        orange "#${orange}"
        cyan "#${cyan}"
        black "#${bg}"
        white "#${fg}"
      }
    }

    keybinds {
      unbind "Alt l" "Alt h"
      normal {
        bind "Ctrl k" { SwitchToMode "tab"; }
      }
      tab {
        bind "h" "Left" { MoveFocusOrTab "Left"; }
        bind "l" "Right" { MoveFocusOrTab "Right"; }
        bind "p" { SwitchFocus; }
      }
    }

    on_force_close "quit"
    mouse_mode false
    simplified_ui true
    pane_frames false
    default_layout "compact"
    copy_command "wl-copy"
    copy_clipboard "primary"
    copy_on_select false
    auto_layout false
    styled_underlines false
    disable_session_metadata true
    ui {
      pane_frames {
        rounded_corners true
        hide_session_name true
      }
    }
  '';
}
