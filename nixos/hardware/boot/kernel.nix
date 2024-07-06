{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernel.sysctl = {
      "kernel.printk" = 2;
      "kernel.nmi_watchdog" = 0;

      "vm.max_map_count" = 2147483642;

      "net.ipv4.tcp_fastopen" = 3;
      "net.core.default_qdisc" = "cake";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.somaxconn" = 1024;
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.tcp_mtu_probing" = 1;
      "net.ipv4.icmp_echo_ignore_all" = 1;
    };

    kernelParams = [
      #"apm=power_off"
      #"acpi=force"
      #"reboot=acpi"
      "nohibernate"
      "ibt=off"
      "rootfstype=btrfs"
    ];
    # supportedFilesystems = [ "btrfs" ];
    # kernelPackages = pkgs.linuxPackages_6_8; intel xe
    extraModprobeConfig = ''
      options i915 enable_guc=2
      options i915 enable_fbc=1
      options i915 fastboot=1 
    '';
    blacklistedKernelModules = [
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
      "nilfs2"
      "omfs"
      "ufs"
    ];
    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usbhid"
    ];
    # initrd.kernelModules = [ ];

    kernelModules = [
      "kvm-intel"
      "i915"
    ]; # "v4l2loopback" ]; # "i915" "uinput" ];
    # extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  };

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", TAG+="uaccess"
  '';

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
