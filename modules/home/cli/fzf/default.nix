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
      defaultCommand = "fd --color never --type file --strip-cwd-prefix";
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
        "--bind 'tab:down,btab:up,alt-j:down,alt-k:up,alt-a:abort,alt-s:jump,alt-c:abort'"
      ];
    };
  };
}
