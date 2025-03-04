{ theme, ... }: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };
  xdg.configFile."zellij/config.kdl".text = with theme;
    let
      back = surface0;
      # kdl
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
          bind "Alt Space" "Space" "i" "c" { SwitchToMode "normal"; }

          bind "j" "Down" { ScrollDown; }
          bind "k" "Up" { ScrollUp; }
          bind "i" { SwitchToMode "normal"; }
        }
        
        renametab {
          bind "Alt Space" "Space" "i" "c" { UndoRenameTab; SwitchToMode "normal"; }
        }

        pane {
          bind "Alt Space" "Space" "i" "c" { SwitchToMode "normal"; }
          
          bind "q" { CloseFocus; SwitchToMode "normal"; }
          bind "f" { ToggleFloatingPanes; SwitchToMode "normal"; }
          bind "e" { EditScrollback; SwitchToMode "Normal"; }
          bind "t" { ToggleFocusFullscreen; SwitchToMode "normal"; }
          bind "Alt n" "n" { NewTab; SwitchToMode "normal"; }
          bind "Alt o" { Resize "increase"; }
          bind "Alt i" { Resize "decrease"; }
          bind "s" { SwitchToMode "scroll"; }
                   
          bind "l" "Alt l" { MoveFocus "Right"; SwitchToMode "Normal"; }
          bind "Shift l" { NewPane "Right"; SwitchToMode "Normal"; }
          bind "Alt Shift l" { MovePane "right"; SwitchToMode "Normal"; }
          
          bind "h" "Alt h" { MoveFocus "Left"; SwitchToMode "Normal"; }
          bind "Shift h" { NewPane "Left"; SwitchToMode "Normal"; }
          bind "Alt Shift h" { MovePane "left"; SwitchToMode "Normal"; }
          
          bind "j" "Alt j" { MoveFocus "Down"; SwitchToMode "Normal"; }
          bind "Shift j" { NewPane "Down"; SwitchToMode "Normal"; }
          bind "Alt Shift j" { MovePane "down"; SwitchToMode "Normal"; }
          
          bind "k" "Alt k" { MoveFocus "Up"; SwitchToMode "Normal"; }
          bind "Shift k" { NewPane "Up"; SwitchToMode "Normal"; }
          bind "Alt Shift k" { MovePane "up"; SwitchToMode "Normal"; }        
          
          bind "1" { GoToTab 1; SwitchToMode "Normal"; }
          bind "2" { GoToTab 2; SwitchToMode "Normal"; }
          bind "3" { GoToTab 3; SwitchToMode "Normal"; }
          bind "4" { GoToTab 4; SwitchToMode "Normal"; }
          bind "5" { GoToTab 5; SwitchToMode "Normal"; }
          bind "6" { GoToTab 6; SwitchToMode "Normal"; }
          bind "7" { GoToTab 7; SwitchToMode "Normal"; }
          bind "8" { GoToTab 8; SwitchToMode "Normal"; }
          bind "9" { GoToTab 9; SwitchToMode "Normal"; }
        }
        
        shared_except "normal" "locked" {
          bind "Ctrl q" { Quit; }
          bind "Ctrl c" { SwitchToMode "Normal"; }
        }

        locked {
          bind "Alt Shift Space" { SwitchToMode "normal"; }
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
        
        shared_except "locked" "pane" {
          bind "Alt Shift Space" { SwitchToMode "locked"; }
          bind "Ctrl Alt r" { SwitchToMode "RenameTab"; TabNameInput 0; }
          bind "Alt Space" { SwitchToMode "pane"; }

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
