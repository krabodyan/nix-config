{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.agenix;
in {
  options = {
    module.agenix = {
      enable = mkEnableOption "agenix";
    };
  };

  config = mkIf cfg.enable {
    home.file.".ssh/id_ed25519.pub" = {
      text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAS98GiFhPvcsST61a6HvWOQr09zoHLTNuydGYt0Rhp";
      executable = false;
    };
  };
}
