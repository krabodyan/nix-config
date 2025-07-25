{
  lib,
  pkgs,
  fonts,
  colors,
  config,
  mkAssociations,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.mpv;
in {
  options = {
    module.mpv = {
      enable = mkEnableOption "mpv";
    };
  };
  config = mkIf cfg.enable {
    xdg.configFile."mpv/mpv.conf".text = with colors.hex; ''
      gpu-context=wayland
      vo=dmabuf-wayland
      volume=50
      keep-open=yes
      fullscreen=yes
      force-window
      sid=0

      audio-file-auto-exts=mkv
      audio-file-auto=fuzzy
      audio-file-paths=RUS Sound

      osd-font='${fonts.monospace}'
      osd-font-size=40
      osd-border-color='${surface1}'
      osd-border-size=1
      osd-color='${fg-bright}'
      osd-shadow-color='${bg}'
    '';
    programs.mpv = {
      enable = true;
      package = pkgs.mpv-unwrapped;
      extraInput = ''
        ESC          quit
        й            quit
        WHEEL_UP     add volume  3
        WHEEL_DOWN   add volume -3
        WHEEL_RIGHT  ignore
        WHEEL_LEFT   ignore
        h            seek       -3
        l            seek        3
        k            add volume  5
        j            add volume -5
        р            seek       -3
        д            seek        3
        л            add volume  5
        о            add volume -5
        UP           add volume  3
        DOWN         add volume -3
        RIGHT        seek        3
        LEFT         seek       -3
        s            ignore
      '';
    };
    xdg.mimeApps.defaultApplications = mkAssociations {
      types = [
        "video/3gp"
        "video/3gpp"
        "video/3gpp2"
        "video/avi"
        "video/divx"
        "video/dv"
        "video/fli"
        "video/flv"
        "video/mp2t"
        "video/mp4"
        "video/mp4v-es"
        "video/mpeg"
        "video/msvideo"
        "video/ogg"
        "video/quicktime"
        "video/vnd.divx"
        "video/vnd.mpegurl"
        "video/vnd.rn-realvideo"
        "video/webm"
        "video/x-avi"
        "video/x-flv"
        "video/x-m4v"
        "video/x-matroska"
        "video/x-mpeg2"
        "video/x-ms-asf"
        "video/x-msvideo"
        "video/x-ms-wmv"
        "video/x-ms-wmx"
        "video/x-ogm"
        "video/x-ogm+ogg"
        "video/x-theora"
        "video/x-theora+ogg"
        "audio/aac"
        "audio/mp4"
        "audio/mpeg"
        "audio/mpegurl"
        "audio/ogg"
        "audio/vnd.rn-realaudio"
        "audio/vorbis"
        "audio/x-flac"
        "audio/x-mp3"
        "audio/x-mpegurl"
        "audio/x-ms-wma"
        "audio/x-musepack"
        "audio/x-oggflac"
        "audio/x-pn-realaudio"
        "audio/x-scpls"
        "audio/x-speex"
        "audio/x-vorbis"
        "audio/x-vorbis+ogg"
        "audio/x-wav"
      ];
      desktop = "mpv.desktop";
    };
  };
}
