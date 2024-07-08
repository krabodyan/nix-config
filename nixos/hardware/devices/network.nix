{ lib, ... }:
{
  networking = {
    dhcpcd = {
      enable = true;
      wait = "background";
      extraConfig = ''
        noarp
        nohook iwd
        #interface enp2s0
        #static ip_address=192.168.1.222
        #static router=192.168.1.1
        #static domain_name_servers=8.8.8.8
      '';
    };
    # nameservers = [
    # "1.1.1.1"
    # "8.8.8.8"
    # "8.8.4.4"
    # ];
    useDHCP = true;
    firewall.enable = false;
    hostName = "nixos";

    wireless = {
      iwd = {
        enable = true;
        settings = {
          General = {
            UseDefaultInterface = true;
            EnableNetworkConfiguration = true;
          };
          Network = {
            EnableIPv6 = true;
          };
          Settings.AutoConnect = true;
          Scan.DisablePeriodicScan = false;
        };
      };
    };
  };
  systemd.services.iwd.wantedBy = lib.mkForce [ ];
}
