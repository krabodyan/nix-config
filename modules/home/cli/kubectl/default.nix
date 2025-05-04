{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.kubectl;
in {
  options = {
    module.kubectl = {
      enable = mkEnableOption "enables kubectl related utils";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kubernetes-helm
      minikube
      kubectx
      kubectl
    ];
  };
}
