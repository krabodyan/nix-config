{pkgs, ...}: {
  boot = {
    initrd.systemd.enable = true;
    initrd.systemd.dbus.enable = true;
    kernel.sysctl = {
      "kernel.printk" = 2;
      "kernel.nmi_watchdog" = 0;
      "kernel.watchdog" = 0;

      "kernel.core_pattern" = "|${pkgs.coreutils}/bin/false";
      "fs.suid_dumpable" = 0;
      "kernel.dmesg_restrict" = 0;

      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 1048576;

      "net.ipv4.tcp_fastopen" = 3;
      "net.core.default_qdisc" = "cake";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.somaxconn" = 1024;
      "net.ipv4.tcp_fin_timeout" = 5;
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.tcp_mtu_probing" = 1;
      "net.ipv4.icmp_echo_ignore_all" = 1;
    };

    kernelParams = [
      "nohibernate"
      "nowatchdog"
      "rootfstype=btrfs"
      "raid=noautodetect"
    ];

    kernelPackages = pkgs.linuxPackages_zen;

    extraModprobeConfig = ''
      options i915 enable_guc=3
      options uvcvideo quirks=0x0104
    '';

    kernelModules = [
      # "kvm-intel"
    ];

    initrd.kernelModules = [];

    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usbhid"
    ];

    initrd.verbose = false;

    blacklistedKernelModules = [
      "iTCO_wdt" # intel watchdog
      "radeon"
      "amdgpu"
      "nouveau"
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
    cpu.intel.updateMicrocode = true;
  };
}
