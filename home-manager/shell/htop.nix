{ config, pkgs, ... }: {
  home.packages = with pkgs; [ nvtopPackages.nvidia gpustat ];
  xdg.configFile."htop/htoprc".force = true;
  programs.htop = {
    enable = true;
    settings = with config.lib.htop;
      leftMeters [ (bar "LeftCPUs2") (text "Blank") (bar "CPU") (bar "Memory") ]
      // rightMeters [
        (bar "RightCPUs2")
        (text "Blank")
        (text "Blank")
        (text "LoadAverage")
      ] // {
        tree_view = false;
        hide_kernel_threads = true;
        hide_userland_threads = true;
        show_program_path = false;
        highlight_base_name = true;
        show_cpu_frequency = true;
        show_cpu_temperature = true;
        cpu_count_from_one = true;
        color_scheme = 6;
        delay = 5;

        fields = with fields; [ PID TIME PERCENT_CPU PERCENT_MEM COMM ];
      };
  };
}
