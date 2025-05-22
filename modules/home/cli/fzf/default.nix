{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.fzf;
in {
  options = {
    module.fzf = {
      enable = mkEnableOption "enable fzf with fd";
    };
  };
  config = mkIf cfg.enable {
    programs.fd = {
      enable = true;
      hidden = false;
      extraOptions = ["--color" "never" "--ignore-case"];
      inherit (config.programs.git) ignores;
    };
    programs.fzf = {
      enable = true;
      enableFishIntegration = false;
      defaultCommand = "fd --type f";
      changeDirWidgetCommand = "fd --type d";
      fileWidgetCommand = "fd --type f";
      defaultOptions = [
        "--no-multi-line"
        "--ignore-case"
        "--algo=v1"
        "--no-mouse"
        "--pointer ' '"
        "--marker ' '"
        "--prompt '󰅂 '"
        "--border none"
        "--ellipsis ''"
        "--no-scrollbar"
        "--no-bold"
        "--no-separator"
        "--height 10"
        "--info hidden"
        "--reverse"
        "--ansi"
        "--bind 'tab:down,btab:up,alt-j:down,alt-k:up,alt-s:jump,alt-c:abort,alt-z:abort,alt-a:abort,alt-r:abort,alt-x:abort'"
      ];
      colors = let
        dark = "8";
        bright = "7";
      in {
        bg = "-1";
        fg = dark;
        hl = dark;
        current-bg = "-1";
        current-fg = bright;
        current-hl = bright;
        info = dark;
        header = dark;
        pointer = bright;
        marker = bright;
        prompt = bright;
        spinner = bright;
        border = "-1";
        gutter = "-1";
      };
    };
  };
}
