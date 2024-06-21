{ pkgs, lib, inputs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.etc.nixpkgs.source = inputs.nixpkgs;
  environment.systemPackages = with pkgs; [
    home-manager
    compsize

    git
    gcc
    pfetch
    inxi
    wget
    tree
    python3
    killall
    ffmpeg-full
    imagemagick
    lm_sensors
    zip unzip
    file
    lshw
    usbutils
    ncdu
    pciutils
    jq

    acpi
    ntfs3g
    pipewire

    # ranger ----
    ranger
    p7zip
    libsixel
    ffmpegthumbnailer
    poppler_utils
    exiftool
    # --------------
  ];
}
