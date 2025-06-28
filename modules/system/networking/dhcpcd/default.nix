{
  lib,
  config,
  hostname,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.networking.dhcpcd;
in {
  options = {
    module.networking.dhcpcd = {
      enable = mkEnableOption "network";
    };
  };
  config = mkIf cfg.enable {
    networking = {
      dhcpcd = {
        enable = true;
        wait = "background";
        extraConfig = ''
          noarp
        '';
      };

      firewall = {
        enable = false;
      };

      useDHCP = true;
      hostName = hostname;
    };
  };
}
