{ pkgs, config, ... }: {

  home.packages = with pkgs; [ hyprlock ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      #hide_cursor = true
      ignore_empty_input = true
    }

    background {
        monitor =
        path = ${config.background-image}
        blur_size = 5
        blur_passes = 3
        noise = 0.0117
        contrast = 1.3000
        brightness = 0.7000
        vibrancy = 0.2100
        vibrancy_darkness = 0.0
    }

    input-field {
        monitor =
        size = 250, 30
        outline_thickness = 2
        dots_size = 0.3 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.64 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        outer_color = rgb(${config.colors.peach})
        inner_color = rgb(${config.colors.bg})
        font_color = rgb(${config.colors.fg})
        fade_on_empty = true
        placeholder_text = <i>Password...</i> # Text rendered in the input box when it's empty.
        hide_input = false
        position = 0, 30
        halign = center
        valign = bottom
        capslock_color = rgb(${config.colors.red})
        numlock_color = -1
        swap_font_color = false
    }

    label {
        monitor =
        text = cmd[update:60000] echo "<b><big> $(date +"%H:%M") </big></b>"
        color = rgb(${config.colors.fg})
        font_size = 64
        font_family = ${config.font}
        position = 0, 16
        halign = center
        valign = center
    }
  '';
}
