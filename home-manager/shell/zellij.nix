{ theme, ... }: {
  programs.zellij = { enable = true; };
  xdg.configFile."zellij/config.kdl".text = with theme;
    let back = surface2;
    in ''
      default_shell "fish"
      themes {
        default {
          bg "#${back}"
          fg "#${back}"
          red "#${red}"
          green "#${green}"
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
        scroll {
          bind "Ctrl j" "Ctrl k" { SwitchToMode "normal"; }
          bind "j" "Down" { ScrollDown; }
          bind "k" "Up" { ScrollUp; }
        }
        
        renametab {
          bind "Esc" "Ctrl c" { UndoRenameTab; SwitchToMode "normal"; }
        }

        pane {
          bind "Esc" "Ctrl c" "Ctrl w" { SwitchToMode "normal"; }
          bind "w" { FocusNextPane; SwitchToMode "normal"; }
          bind "o" { Resize "increase"; }
          bind "i" { Resize "decrease"; }
          
          bind "Alt l" { NewPane "Right"; SwitchToMode "Normal"; }
          bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
          bind "Alt h" { NewPane "Left"; SwitchToMode "Normal"; }
          bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
          bind "Alt j" { NewPane "Down"; SwitchToMode "Normal"; }
          bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
          bind "Alt k" { NewPane "Up"; SwitchToMode "Normal"; }
          bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
        }
        
        shared_except "normal" "locked" {
          bind "Enter" "Esc" { SwitchToMode "Normal"; }
        }

        locked {
          bind "Ctrl Alt l" { SwitchToMode "normal"; }
        }
        
        shared_except "locked" {
          bind "Ctrl Alt l" { SwitchToMode "locked"; }
          bind "Ctrl r" { SwitchToMode "RenameTab"; TabNameInput 0; }
          bind "Ctrl w" { SwitchToMode "pane"; }
          bind "Ctrl j" "Ctrl k" { SwitchToMode "scroll"; }

          bind "Ctrl n" { NewTab; }
          
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
      support_kitty_keyboard_protocol false
      session_serialization false
      pane_viewport_serialization false
      default_layout "compact"
      copy_command "wl-copy"
      copy_clipboard "primary"
      copy_on_select false
      auto_layout false
      styled_underlines false
      disable_session_metadata true
      pane_frames false
      ui {
        pane_frames {
          hide_session_name true
        }
      }
    '';
}
