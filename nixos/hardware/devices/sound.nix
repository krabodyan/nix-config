{ pkgs, ... }:
{
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # extraConfig.pipewire = {
    #   "default.clock.rate" = 48000;
    #   "default.clock.allowed-rates" = [
    #     48000
    #   ];
    #   "default.clock.quantum" = 8192;
    # "default.clock.max-quantum" = 4096;
    # "default.clock.min-quantum" = 1024;
    # };
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/main.lua.d/50-alsa-config.lua" ''
        ["api.alsa.period-size"] = 128,
        ["api.alsa.headroom"] = 1024,
      '')
    ];
  };
}
