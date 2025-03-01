{ pkgs, ... }: {
  home.packages = [ pkgs.htop ];
  xdg.configFile."htop/htoprc" = {
    force = true;
    text = ''
      color_scheme=6
      cpu_count_from_one=1
      delay=5
      fields=0 49 46 47 1
      hide_kernel_threads=1
      hide_userland_threads=1
      highlight_base_name=1
      left_meter_modes=1 2 1 1
      left_meters=LeftCPUs2 Blank CPU Memory
      right_meter_modes=1 2 2 2
      right_meters=RightCPUs2 Blank Blank LoadAverage
      show_cpu_frequency=1
      show_cpu_temperature=1
      show_program_path=0
      tree_view=0
    '';
  };
}
