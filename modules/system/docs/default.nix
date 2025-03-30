{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.docs;
in {
  options = {
    module.docs = {
      enable = mkEnableOption "docs settings";
    };
  };
  config = mkIf cfg.enable {
    documentation = {
      enable = true;
      man.enable = true;
      dev.enable = lib.mkForce false;
      doc.enable = lib.mkForce false;
      info.enable = lib.mkForce false;
      nixos.enable = lib.mkForce false;
    };
  };
}
