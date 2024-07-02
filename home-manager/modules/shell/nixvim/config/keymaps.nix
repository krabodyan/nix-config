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
          "<C-n>" = ":Neotree toggle<CR>";
          "<esc>" = ":noh<CR>";
          "<C-k>" = ":lua require('whitespace-nvim').trim()<CR>";    
          Y = "y$";
          "<C-q>" = ":close<CR>";
          "<C-x>" = ":qa<CR>";
          "<C-s>" = ":w<CR>";

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
