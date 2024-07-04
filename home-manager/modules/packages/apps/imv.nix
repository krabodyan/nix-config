{ pkgs, config, ... }: {
  xdg.configFile."swayimg/config".text = with config.colors;
    ''
      [general]
      scale = optimal
      fullscreen = yes
      antialiasing = no
      transparency = grid
      background = #${bg}
      slideshow = no

      [font]
      name = ${config.font}
      size = 12
      color = #${fg}
      shadow = #000000

      [keys]
      left = rotate_left
      right = rotate_right
      bracketleft = flip_vertical
      bracketright = flip_horizontal
      up = prev_file
      down = next_file

      [info]
      mode = brief
      brief.topleft = name

      [mouse]
      Shift+ScrollUp = step_down 5
      Shift+ScrollDown = step_up 5
      ScrollUp = zoom +10
      ScrollDown = zoom -10

      [list]
      order = alpha
      loop = no
      recursive = no
      all = yes
    '';
  home.packages = [ pkgs.swayimg ];
  xdg.mimeApps =
    let
      associations = {
        "image/jpeg" = "swayimg.desktop";
        "image/png" = "swayimg.desktop";
        "image/webp" = "swayimg.desktop";
        "image/svg" = "swayimg.desktop";
        "image/jpg" = "swayimg.desktop";
      };
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };
}
