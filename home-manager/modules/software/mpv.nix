{ pkgs, ...}: {
  home.file.".config/mpv/mpv.conf".text = ''
    gpu-context=wayland
    vo=gpu
    profile=fast
    hwdec=vaapi
    volume=65
    keep-open=yes
    fullscreen=no
    sid=0
    initial-audio-sync
    ytdl-format=bestvideo[height<=?1080][ext=mp4][vcodec^=avc1]+bestaudio[ext=m4a]
    script-opts=ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp

    [extension.mkv]
    profile-desc="profile for .mkv files"
    audio-file-auto=exact
  '';
  programs.mpv = {
    enable = true;
    extraInput = ''
      WHEEL_UP        add volume  5
      WHEEL_DOWN      add volume -5
      WHEEL_LEFT      seek       -3
      WHEEL_RIGHT     seek        3
      UP              add volume  5
      DOWN            add volume -5
      '';
  };
}
