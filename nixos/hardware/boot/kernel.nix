{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.kernelParams = [
    "info"
    "splash"
    #"apm=power_off"
    #"acpi=force"
    #"reboot=acpi"
    "nohibernate"
    # "ibt=off"
    "raid=noautodetect"
    # "rootfstype=btrfs"
  ];
  # boot.supportedFilesystems = [ "btrfs" ];
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  # boot.extraModprobeConfig = '''';
  boot.blacklistedKernelModules = [
    "adfs" "affs" "bfs" "befs"
    "cramfs" "efs" "erofs" "exofs"
    "freevxfs" "f2fs" "hfs" "hpfs"
    "jfs" "nilfs2" "omfs"
    "ufs"
  ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" ];
  # boot.initrd.kernelModules = [ ];

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", TAG+="uaccess"
  '';

  boot.kernelModules = [ "kvm-intel" ]; #"v4l2loopback" ]; # "i915" "uinput" ];
  # boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
