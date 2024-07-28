{ config, helpers, ... }:
{
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
      with helpers;
      {
        "bg+" = "-1";
        bg = "-1";
        spinner = mkHex accent;
        hl = mkHex accent;
        fg = mkHex fg-dark;
        "fg+" = mkHex fg;
        header = mkHex accent;
        info = mkHex blue;
        pointer = mkHex accent;
        marker = mkHex accent;
        prompt = mkHex accent;
        "hl+" = mkHex green;
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
