{
  lib,
  pkgs,
  colors,
  config,
  systemFont,
  mkAssociations,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.swayimg;
in {
  options = {
    module.swayimg = {
      enable = mkEnableOption "enable swayimg";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.swayimg];
    xdg.configFile."swayimg/config".text = with colors.hex; ''
      [general]
      size = fullscreen

      [viewer]
      scale = optimal
      transparency = grid
      window = ${bg}ff
      slideshow = no

      [font]
      name = ${systemFont}
      size = 14
      color = ${fg}ff
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
    xdg.mimeApps.defaultApplications = mkAssociations {
      types = [
        "image/png"
        "image/jpeg"
        "image/webp"
        "image/svg"
        "image/heic"
        "image/avif"
        "image/heif"
        "image/jpg"
        "image/svg+xml"
        "image/x-ico"
        "image/x-portable-bitmap"
        "image/x-portable-graymap"
        "image/x-portable-swayimgmap"
        "image/x-xbitmap"
        "image/x-xswayimgmap"
        "image/tiff"
        "image/x-icns"
        "image/x-eps"
        "image/bmp"
        "image/png"
        "image/jxl"
        "image/gif"
        "image/x-psd"
        "image/x-webp"
        "image/x-tga"
        "image/svg+xml"
      ];
      desktop = "swayimg.desktop";
    };
  };
}
