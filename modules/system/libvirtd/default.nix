{
  lib,
  pkgs,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.libvirtd;
in {
  options = {
    module.libvirtd = {
      enable = mkEnableOption "enable libvirtd";
    };
  };
  config = mkIf cfg.enable {
    users.extraGroups = {
      libvirtd.members = [username];
      libvirtd-qemu.members = [username];
      kvm.members = [username];
    };

    virtualisation.libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
    programs.virt-manager.enable = true;
  };
}
