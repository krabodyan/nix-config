{ config, ... }:
{
  programs.zellij = {
    enable = true;
  };
  xdg.configFile."zellij/config.kdl".text = with config.colors; ''
    themes {
      default {
        bg "#${surface2}"
        fg "#${surface2}"
        red "#${red}"
        green "#${accent}"
        blue "#${cyan}"
        yellow "#${yellow}"
        magenta "#${magenta}"
        orange "#${green}"
        cyan "#${blue}"
        black "#${bg}"
        white "#${surface2}"
      }
    }

    keybinds {
      unbind "Alt l" "Alt h" "Ctrl s"
      normal {
        bind "Alt i" { SwitchToMode "tab"; }
        bind "Ctrl j" { SwitchToMode "scroll"; }
      }
      tab {
        bind "Ctrl c" { SwitchToMode "normal"; }
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
