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
        bg = "-1";
        fg = mkHex fg-dark;
        hl = mkHex fg-dark;
        current-bg = "-1";
        current-fg = mkHex fg;
        current-hl = mkHex fg;

        info = mkHex fg-dark;
        header = mkHex fg-dark;
        pointer = mkHex red;
        marker = mkHex fg;
        prompt = mkHex fg;
        spinner = mkHex fg;
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
      "--bind 'tab:toggle-down,btab:toggle-up,alt-a:abort,alt-s:jump'"
    ];
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
