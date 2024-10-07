{ config, helpers, ... }:
{
  home.sessionVariables.LS_COLORS = "di=1;33";
  programs.fd = {
    enable = true;
    hidden = false;
    extraOptions = [
      "--color"
      "never"
      "--type"
      "file"
    ];
    inherit (config.programs.git) ignores;
  };
  programs.fzf = {
    enable = true;
    colors =
      with config.colors;
      let
        inherit (helpers) mkHex;
        fg = mkHex config.colors.fg;
      in
      {
        "bg+" = "-1";
        bg = "-1";
        spinner = fg;
        hl = fg;
        fg = mkHex fg-dark;
        "fg+" = fg;
        header = fg;
        info = fg;
        pointer = fg;
        marker = fg;
        prompt = fg;
        "hl+" = mkHex yellow;
        border = "-1";
        gutter = "-1";
      };
    defaultOptions = [
      "--pointer ' '"
      "--marker ' '"
      "--prompt '󰅂 '"
      "--border none"
      "--ellipsis ''"
      "--no-scrollbar"
      "--no-separator"
      "--height 7"
      "--info hidden"
      "--reverse"
      "--bind 'tab:toggle-down,btab:toggle-up'"
    ];
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
