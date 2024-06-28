{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    home-manager
    compsize

    git
    gcc
    inxi
    wget
    python3Full
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
    pkg-config
    libusb1

    acpi
    ntfs3g
  ];
}
