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
    home.file.".kube/kubie.yaml".text =
      # yaml
      ''
        shell: fish
        default_editor: hx

        configs:
          include:
            - ~/.kube/config
            - ~/.kube/*.yml
            - ~/.kube/*.yaml
            - ~/.kube/configs/*.yml
            - ~/.kube/configs/*.yaml
            - ~/.kube/kubie/*.yml
            - ~/.kube/kubie/*.yaml
          exclude:
            - ~/.kube/kubie.yaml

        prompt:
          disable: true
          show_depth: false
          zsh_use_rps1: false
          fish_use_rprompt: false
          xonsh_use_right_prompt: false

        behavior:
          validate_namespaces: true
          print_context_in_exec: auto
      '';

    home.packages = with pkgs; [
      kubernetes-helm
      kubie
      kubectl
    ];
  };
}
