{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.gh;
in {
  options = {
    module.gh = {
      enable = mkEnableOption "enable gh";
    };
  };

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        prefer_editor_prompt = "enabled";
      };
    };
  };
}
