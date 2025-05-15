{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.networking.dhcpcd;
in {
  options = {
    module.networking.dhcpcd = {
      enable = mkEnableOption "enable network";
      hostname = mkOption {
        type = lib.types.str;
        example = "nixos";
      };
    };
  };
  config = mkIf cfg.enable {
    networking = {
      dhcpcd = {
        enable = true;
        wait = "background";
        extraConfig = ''
          nohook iwd
        '';
      };

      firewall = {
        enable = false;
      };

      useDHCP = true;
      hostName = cfg.hostname;
    };
  };
}
