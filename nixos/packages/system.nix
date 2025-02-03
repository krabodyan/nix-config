{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # compsize
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
    pciutils
    acpi
    ntfs3g
  ];
}
