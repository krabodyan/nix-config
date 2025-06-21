{
  lib,
  config,
  publicKey,
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
      text = publicKey;
      executable = false;
    };
  };
}
