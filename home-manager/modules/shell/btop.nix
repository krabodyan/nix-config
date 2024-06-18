{ config, pkgs, ... }: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "kyli0x";
      theme_background = false;
      vim_keys = true;
      update_ms = 200;
      presets = "proc:0:default";
      graph_symbol = "block";
      proc_sorting = "memory";
      background_update = false;
      show_swap = false;
      use_fstab = true;
      show_io_stat = false;
      show_battery = false;
      show_disks = false;
      show_uptime = false;
      proc_left = true;
      proc_gradient = false;
    };
  };
}
