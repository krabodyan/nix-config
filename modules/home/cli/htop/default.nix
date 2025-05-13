{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.htop;
in {
  options = {
    module.htop = {
      enable = mkEnableOption "enable htop";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.htop-vim];
    xdg.configFile."htop/htoprc" = {
      force = true;
      text = ''
        color_scheme=6
        screen_tabs=1
        cpu_count_from_one=1
        delay=5
        hide_kernel_threads=1
        hide_userland_threads=1
        highlight_base_name=1
        highlight_megabytes=0
        header_margin=0
        left_meter_modes=1 2 1 1
        left_meters=LeftCPUs2 Blank CPU Memory
        right_meter_modes=1 2 2 2
        right_meters=RightCPUs2 Blank Tasks LoadAverage
        show_cpu_frequency=1
        show_cpu_temperature=1
        show_program_path=0
        tree_view=1
      '';
    };
  };
}
