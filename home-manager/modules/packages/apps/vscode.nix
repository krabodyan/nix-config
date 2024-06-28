programs.vscode = {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    catppuccin.catppuccin-vsc
    catppuccin.catppuccin-vsc-icons
    jnoortheen.nix-ide
    ms-python.python
  ];
};
