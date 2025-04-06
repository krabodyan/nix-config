{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.module.docs;
in {
  options = {
    module.docs = {
      enable = mkEnableOption "docs settings";
    };
  };
  config.documentation = {
    enable = lib.mkForce cfg.enable;
    man.enable = lib.mkForce cfg.enable;
    dev.enable = lib.mkForce false;
    doc.enable = lib.mkForce false;
    info.enable = lib.mkForce false;
    nixos.enable = lib.mkForce false;
  };
}
