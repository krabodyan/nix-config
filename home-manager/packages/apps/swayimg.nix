{
  pkgs,
  config,
  helpers,
  ...
}:
{
  home.packages = [ pkgs.swayimg ];
  xdg.configFile."swayimg/config".text = with config.colors; ''
    [general]
    size = fullscreen

    [viewer]
    scale = optimal
    transparency = grid
    window = #${bg}ff
    slideshow = no

    [font]
    name = ${config.font}
    size = 14
    color = #${fg}ff
    shadow = #000000a0

    [keys.viewer]
    k = prev_file
    j = next_file
    left = rotate_left
    right = rotate_right
    bracketleft = flip_vertical
    bracketright = flip_horizontal
    up = prev_file
    down = next_file
    Shift+ScrollUp = step_down 5
    Shift+ScrollDown = step_up 5
    ScrollUp = zoom +10
    ScrollDown = zoom -10

    [info]
    show = yes

    [info.gallery]
    top_left = +name,+format,+filesize,+imagesize,+exif
    top_right = index
    bottom_left = scale,frame
    bottom_right = status

    [info.viewer]
    top_left = name,status
    top_right = none
    bottom_right = none
    bottom_left = none

    [list]
    order = alpha
    loop = no
    recursive = no
    all = yes
  '';
  xdg.mimeApps.defaultApplications = helpers.mkAssociations {
    types = [
      "image/png"
      "image/jpeg"
      "image/webp"
      "image/webp"
      "image/svg"
      "image/heic"
      "image/avif"
      "image/heif"
      "image/svg+xml"
    ];
    desktop = "swayimg.desktop";
  };
}
