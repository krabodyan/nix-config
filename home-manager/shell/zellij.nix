{ config, ... }:
{
  programs.zellij = {
    enable = true;
  };
  xdg.configFile."zellij/config.kdl".text =
    with config.colors;
    let
      back = surface2;
      front = border;
    in
    ''
      themes {
        default {
          bg "#${back}"
          fg "#${back}"
          red "#${red}"
          green "#${front}"
          blue "#${cyan}"
          yellow "#${yellow}"
          magenta "#${magenta}"
          orange "#${red}"
          cyan "#${blue}"
          black "#${bg}"
          white "#${back}"
        }
      }

      keybinds clear-defaults=true {
        normal {
          bind "Ctrl r" { SwitchToMode "RenameTab"; TabNameInput 0; }
        }
        
        scroll {
          bind "Ctrl j" { SwitchToMode "normal"; }
          bind "j" "Down" { ScrollDown; }
          bind "k" "Up" { ScrollUp; }
        }
        
        renametab {
          bind "Esc" "Ctrl c" { UndoRenameTab; SwitchToMode "normal"; }
        }
        
        shared_except "normal" "locked" {
          bind "Enter" "Esc" { SwitchToMode "Normal"; }
        }
        
        shared_except "locked" {
          bind "Ctrl n" { NewTab; }
          bind "Ctrl j" { SwitchToMode "scroll"; }
          bind "Alt 1" { GoToTab 1; SwitchToMode "Normal"; }
          bind "Alt 2" { GoToTab 2; SwitchToMode "Normal"; }
          bind "Alt 3" { GoToTab 3; SwitchToMode "Normal"; }
          bind "Alt 4" { GoToTab 4; SwitchToMode "Normal"; }
          bind "Alt 5" { GoToTab 5; SwitchToMode "Normal"; }
          bind "Alt 6" { GoToTab 6; SwitchToMode "Normal"; }
          bind "Alt 7" { GoToTab 7; SwitchToMode "Normal"; }
          bind "Alt 8" { GoToTab 8; SwitchToMode "Normal"; }
          bind "Alt 9" { GoToTab 9; SwitchToMode "Normal"; }
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
          hide_session_name true
        }
      }
    '';
}
