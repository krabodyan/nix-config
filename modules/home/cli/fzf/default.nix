{
  lib,
  config,
  colors,
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
      extraOptions = ["--color" "never" "--strip-cwd-prefix" "--ignore-case"];
      inherit (config.programs.git) ignores;
    };
    programs.fzf = {
      enable = true;
      colors = with colors.hex; {
        bg = "-1";
        fg = fg-dark;
        hl = fg-dark;
        current-bg = "-1";
        current-fg = fg;
        current-hl = fg;
        info = fg-dark;
        header = fg-dark;
        pointer = red;
        marker = fg;
        prompt = fg;
        spinner = fg;
        border = "-1";
        gutter = "-1";
      };
      defaultCommand = "fd --type f";
      changeDirWidgetCommand = "fd --type d";
      fileWidgetCommand = "fd --type f";
      defaultOptions = [
        "--pointer ' '"
        "--marker ' '"
        "--prompt '󰅂 '"
        "--border none"
        "--ellipsis ''"
        "--no-scrollbar"
        "--no-bold"
        "--no-separator"
        "--height 7"
        "--info hidden"
        "--reverse"
        "--bind 'tab:down,btab:up,alt-j:down,alt-k:up,alt-s:jump,alt-c:abort,alt-z:abort,alt-a:abort,alt-r:abort'"
      ];
    };
  };
}
