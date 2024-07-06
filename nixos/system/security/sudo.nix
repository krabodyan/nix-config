{
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraConfig = ''
      permit persist keepenv :wheel
      permit nopass krabodyan as root cmd reboot
      permit nopass krabodyan as root cmd shutdown
      permit nopass krabodyan as root cmd intel_gpu_top
    '';
  };
}
