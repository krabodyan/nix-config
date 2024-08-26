{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # compsize
    ffmpeg-full
    python3Full

    git
    gcc
    inxi
    wget
    killall
    imagemagick
    lm_sensors
    zip
    unzip
    file
    lshw
    usbutils
    ncdu
    pciutils
    jq
    acpi
    ntfs3g
  ];
}
