{ config, ... }:
{
  xdg.configFile."mpv/mpv.conf".text = with config.colors; ''
    gpu-context=wayland
    vo=gpu
    profile=fast
    hwdec=vaapi
    volume=50
    keep-open=yes
    fullscreen=no
    sid=0

    audio-file-auto-exts=mkv
    audio-file-auto=fuzzy
    audio-file-paths=RUS Sound

    osd-font='${config.font}'
    osd-font-size=40
    osd-border-color='#${bg-bright}'
    osd-border-size=2
    osd-color='#${accent}'
    osd-shadow-color='#${accent}'
  '';
  programs.mpv = {
    enable = true;
    extraInput = ''
      WHEEL_UP     add volume  5
      WHEEL_DOWN   add volume -5
      h            seek       -3
      l            seek        3
      k            add volume  5
      j            add volume -5
      UP           add volume  5
      DOWN         add volume -5
      RIGHT        seek        3
      LEFT         seek       -3
      s            ignore
    '';
  };
}
