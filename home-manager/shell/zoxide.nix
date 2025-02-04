{ config, theme, helpers, ... }: {
  programs.fd = {
    enable = true;
    hidden = false;
    extraOptions = [ "--color" "never" "--type" "file" ];
    inherit (config.programs.git) ignores;
  };
  programs.fzf = {
    enable = true;
    colors = with theme;
      let inherit (helpers) mkHex;
      in {
        "bg+" = "-1";
        bg = "-1";
        spinner = mkHex fg;
        hl = mkHex fg;
        fg = mkHex fg-dark;
        "fg+" = mkHex fg;
        header = mkHex fg-dark;
        info = mkHex fg-dark;
        pointer = mkHex fg-dark;
        marker = mkHex fg;
        prompt = mkHex fg;
        "hl+" = mkHex fg;
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
      "--no-bold"
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
