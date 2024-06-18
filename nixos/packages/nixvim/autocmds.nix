{
  programs.nixvim = {
    autoCmd = [
      {
        event = [ "VimLeave" ];
        command = ":set guicursor=a:hor20";
      }
      {
        event = [ "TextYankPost" ];
        command = ":lua vim.highlight.on_yank({ higroup=\"IncSearch\", timeout=300})";
      }
    ];
  };
}
