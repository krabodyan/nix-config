{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.kernelParams = [
    "info"
    "splash"
    "apm=power_off"
    "acpi=force"
    "reboot=acpi"
    "nohibernate"
    "ibt=off"
    "raid=noautodetect"
    "rootfstype=btrfs"
  ];
  boot.supportedFilesystems = [ "btrfs" "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.extraModprobeConfig = '''';
  boot.blacklistedKernelModules = [
    "ax25" "netrom" "rose"
    "adfs" "affs" "bfs" "befs"
    "cramfs" "efs" "erofs" "exofs"
    "freevxfs" "f2fs" "hfs" "hpfs"
    "jfs" "minix" "nilfs2" "omfs"
    "qnx4" "qnx6" "sysv" "ufs"
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", TAG+="uaccess"
  '';

  boot.kernelModules = [ "kvm-intel" ]; #"v4l2loopback" ]; # "i915" "uinput" ];
  # boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
