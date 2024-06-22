{ pkgs, ... } :
{
  imports = [ ./config ];

  programs.nixvim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraConfigLua = (builtins.readFile ./config/config.lua);

    extraPlugins = with pkgs; [
      vimPlugins.remember-nvim
      vimPlugins.whitespace-nvim
      vimPlugins.catppuccin-nvim
    ];

    plugins = import ./plugins {};
  };
}
