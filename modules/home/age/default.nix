{
  lib,
  keys,
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
    home.file =
      lib.mapAttrs'
      (name: key: {
        name = "ssh-${name}";
        value = {
          text = key;
          force = true;
          executable = false;
          target = ".ssh/${name}.pub";
        };
      })
      keys;
  };
}
