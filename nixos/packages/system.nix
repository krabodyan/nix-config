{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # compsize
    ffmpeg-full

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
