{
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "default.clock.rate" = "48000";
      "default.clock.allowed-rates" = "[ 48000 ]";
      "default.clock.quantum" = "2048";
      "default.clock.max-quantum" = "4096";
      "default.clock.min-quantum" = "1024";
    };
    # extraConfig.pipewire-pulse = {
    #   "pulse.min.req" = "1024/48000";
    #   "pulse.min.frag" = "1024/48000";
    #   "pulse.min.quantum" = "1024/48000";
    # };
  };
}
