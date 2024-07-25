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
  # xdg.mimeApps =
  #   let
  #     videoTypes = [
  #       "video/3gp"
  #       "video/3gpp"
  #       "video/3gpp2"
  #       "video/avi"
  #       "video/divx"
  #       "video/dv"
  #       "video/fli"
  #       "video/flv"
  #       "video/mkv"
  #       "video/mp2t"
  #       "video/mp4"
  #       "video/mp4v-es"
  #       "video/mpeg"
  #       "video/msvideo"
  #       "video/ogg"
  #       "video/quicktime"
  #       "video/vnd.divx"
  #       "video/vnd.mpegurl"
  #       "video/vnd.rn-realvideo"
  #       "video/webm"
  #       "video/x-avi"
  #       "video/x-flc"
  #       "video/x-flic"
  #       "video/x-flv"
  #       "video/x-m4v"
  #       "video/x-matroska"
  #       "video/x-mpeg2"
  #       "video/x-mpeg3"
  #       "video/x-ms-afs"
  #       "video/x-ms-asf"
  #       "video/x-ms-wmv"
  #       "video/x-ms-wmx"
  #       "video/x-ms-wvxvideo"
  #       "video/x-msvideo"
  #       "video/x-ogm"
  #       "video/x-ogm+ogg"
  #       "video/x-theora"
  #       "video/x-theora+ogg"
  #     ];
  #     makeAssociations =
  #       types:
  #       builtins.listToAttrs (
  #         map (type: {
  #           name = type;
  #           value = "mpv.desktop";
  #         }) types
  #       );
  #     associations = makeAssociations videoTypes;
  #   in
  #   {
  #     associations.added = associations;
  #     defaultApplications = associations;
  #   };
}
