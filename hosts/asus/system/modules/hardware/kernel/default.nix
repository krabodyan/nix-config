{
  lib,
  config,
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

    kernelModules = [
      "kvm-intel"
    ];

    initrd.kernelModules = [
      "i915"
    ];

    initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid"];
    initrd.verbose = false;

    blacklistedKernelModules = [
      "appletalk"
      "decnet"
      "ax25"
      "netrom"
      "rose"
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
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
