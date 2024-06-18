{ config, lib, ... }: {
  programs.nixvim = {
    keymaps = let
      normal =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
        })

        {
          # Open Neotree
          "<C-n>" = ":Neotree toggle<CR>";

          # Esc to clear search results
          "<esc>" = ":noh<CR>";
          "<C-k>" = ":lua require('whitespace-nvim').trim()<CR>";
          # fix Y behaviour
          Y = "y$";
          # back and fourth between the two most recent files
          # "<C-c>" = ":b#<CR>";

          # close by Ctrl+x
          "<C-q>" = ":close<CR>";
          "<C-x>" = ":qa<CR>";
          "<C-s>" = ":w<CR>";
          #"<leader>h" = "<C-w>h";
          #"<leader>j" = "<C-w>j";
          #"<leader>k" = "<C-w>k";
          #"<leader>l" = "<C-w>l";

          # resize with arrows
          #"<C-Up>" = ":resize -2<CR>";
          #"<C-Left>" = ":vertical resize +2<CR>";
          #"<C-Down>" = ":resize +2<CR>";
          #"<C-Right>" = ":vertical resize -2<CR";
          # move current line up/down
          # M = Alt key
          "<C-A-Up>" = ":move-2<CR>";
          "<C-A-Down>" = ":move+<CR>";
        };
      visual =
        lib.mapAttrsToList
        (key: action: {
          mode = "v";
          inherit action key;
        })
        {
          # move selected line / block of text in visual mode
          #"K" = ":m '<-2<CR>gv=gv";
          #"J" = ":m '>+1<CR>gv=gv";
        };
    in
      config.nixvim.helpers.keymaps.mkKeymaps
      {options.silent = true;}
      (normal ++ visual);
  };
}
