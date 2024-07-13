{ pkgs, ... }:
{
  home.packages = [ pkgs._64gram ];
  xdg.desktopEntries."io.github.tdesktop_x64.TDesktop" = {
    name = "Telegram Desktop";
    exec = "env QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop -- %u";
  };
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/tg" = [ "io.github.tdesktop_x64.TDesktop.desktop" ];
  };

  home.file = {
    #  ".local/share/64Gram/tdata/1experimental_options.json".text = ''
    #  '';
    ".local/share/64Gram/tdata/enhanced-settings-custom.json".text = ''
      {
          "always_delete_for": 3,
          "auto_unmute": false,
          "bitrate": 1,
          "blocked_user_spoiler_mode": false,
          "disable_cloud_draft_sync": true,
          "disable_global_search": true,
          "disable_link_warning": true,
          "disable_premium_animation": true,
          "hd_video": true,
          "hide_all_chats": false,
          "hide_classic_fwd": false,
          "hide_counter": true,
          "hide_stories": true,
          "net_dl_speed_boost": false,
          "net_speed_boost": 0,
          "radio_controller": "http://localhost:2468",
          "recent_display_limit": 0,
          "repeater_reply_to_orig_msg": false,
          "replace_edit_button": false,
          "show_emoji_button_as_text": false,
          "show_group_sender_avatar": false,
          "show_messages_id": false,
          "show_phone_number": false,
          "show_repeater_option": false,
          "show_scheduled_button": false,
          "show_seconds": true,
          "skip_to_next": false,
          "stereo_mode": false,
          "translate_to_tc": false
      }
    '';
  };
}
