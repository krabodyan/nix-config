{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.graphics.minimal;
in {
  options = {
    module.graphics.minimal = {
      enable = mkEnableOption "enable minimal graphics support";
    };
  };
  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    environment.systemPackages = with pkgs; [
      mesa
      mesa-demos
      vulkan-tools
      libva-utils
    ];
  };
}
