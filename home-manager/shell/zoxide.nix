{ config, helpers, ... }:
{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    colors =
      with config.colors;
      with helpers;
      {
        "bg+" = mkHex bg;
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
        "hl+" = mkHex red;
        border = "-1";
        gutter = "-1";
      };
    defaultOptions = [
      "--pointer '󰧞'"
      "--marker '󰧞'"
      "--prompt '~ '"
      "--border none"
      "--ellipsis ''"
      "--no-scrollbar"
      "--no-separator"
      "--height '60%'"
    ];
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
