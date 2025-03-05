{ config, theme, ... }: {
  programs.fd = {
    enable = true;
    hidden = false;
    extraOptions = [ "--color" "never" "--type" "file" ];
    inherit (config.programs.git) ignores;
  };
  programs.fzf = {
    enable = true;
    colors = with theme.colorsHex; {
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
