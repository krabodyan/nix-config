{ theme, ... }: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };
  xdg.configFile."zellij/config.kdl".text = with theme;
    let back = surface0;
    in ''
      default_shell "fish"
      themes {
        default {
          bg "#${back}"
          fg "#${back}"
          red "#${red}"
          green "#${overlay0}"
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
          bind "Ctrl c" "s" { SwitchToMode "normal"; }
          bind "j" "Down" { ScrollDown; }
          bind "k" "Up" { ScrollUp; }
        }
        
        renametab {
          bind "Ctrl c" { UndoRenameTab; SwitchToMode "normal"; }
        }

        pane {
          bind "Alt w" { SwitchToMode "normal"; }
          bind "Alt q" { CloseFocus; SwitchToMode "normal"; }
          
          bind "d" { ToggleFloatingPanes; SwitchToMode "normal"; }
          bind "e" { EditScrollback; SwitchToMode "Normal"; }
          bind "f" { ToggleFocusFullscreen; SwitchToMode "normal"; }
          bind "i" { Resize "decrease"; }
          bind "n" { NewTab; SwitchToMode "normal"; }
          bind "o" { Resize "increase"; }
          bind "s" { SwitchToMode "scroll"; }
          bind "space" { FocusNextPane; SwitchToMode "normal"; }

          bind "Ctrl l" { GoToNextTab; }
          bind "Ctrl h" { GoToPreviousTab;  }
          
          bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
          bind "Alt l" { NewPane "Right"; SwitchToMode "Normal"; }
          bind "Alt Shift l" { MovePane "right"; SwitchToMode "Normal"; }
          
          bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
          bind "Alt h" { NewPane "Left"; SwitchToMode "Normal"; }
          bind "Alt Shift h" { MovePane "left"; SwitchToMode "Normal"; }
          
          bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
          bind "Alt j" { NewPane "Down"; SwitchToMode "Normal"; }
          bind "Alt Shift j" { MovePane "down"; SwitchToMode "Normal"; }
          
          bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
          bind "Alt k" { NewPane "Up"; SwitchToMode "Normal"; }
          bind "Alt Shift k" { MovePane "up"; SwitchToMode "Normal"; }        
        }
        
        shared_except "normal" "locked" {
          bind "Ctrl q" { Quit; }
          bind "Ctrl c" { SwitchToMode "Normal"; }
        }

        locked {
          bind "Ctrl Alt k" { SwitchToMode "normal"; }
          bind "Alt 1" { GoToTab 1; }
          bind "Alt 2" { GoToTab 2; }
          bind "Alt 3" { GoToTab 3; }
          bind "Alt 4" { GoToTab 4; }
          bind "Alt 5" { GoToTab 5; }
          bind "Alt 6" { GoToTab 6; }
          bind "Alt 7" { GoToTab 7; }
          bind "Alt 8" { GoToTab 8; }
          bind "Alt 9" { GoToTab 9; }
        }
        
        shared_except "locked" {
          bind "Ctrl Alt k" { SwitchToMode "locked"; }
          bind "Ctrl Alt r" { SwitchToMode "RenameTab"; TabNameInput 0; }
          bind "Alt w" { SwitchToMode "pane"; }

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
      mouse_mode true
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
