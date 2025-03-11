{
  lib,
  config,
  pkgs,
  ...
}: {
  boot = {
    kernel.sysctl = {
      "kernel.printk" = 2;
      "kernel.nmi_watchdog" = 0;

      "kernel.core_pattern" = "|/bin/false";
      "fs.suid_dumpable" = 0;
      "kernel.dmesg_restrict" = 0;

      "vm.max_map_count" = 2147483642;
      "vm.min_free_kbytes" = 1048576;
    };

    kernelParams = ["nohibernate" "rootfstype=btrfs" "raid=noautodetect"];
    # kernelPackages = pkgs.linuxPackages_latest;
    extraModprobeConfig = ''
      options i915 enable_guc=3
    '';
    blacklistedKernelModules = [
      "appletalk"
      "decnet"

      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"

      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "ntfs"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "ufs"
    ];

    initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid"];
    # initrd.kernelModules = [ ];
    initrd.verbose = false;
    # kernelModules = [ "v4l2loopback" ]; # "i915" "uinput" ];
    # extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  };

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", TAG+="uaccess"
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTR{power/wakeup}="disabled"
    SUBSYSTEM=="drm", KERNEL=="card*", ATTRS{device}=="0x9a68", SYMLINK+="dri/igpu"
  '';
  services.udev.packages = with pkgs; [platformio-core.udev];

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
