{
  pkgs,
  config,
  inputs,
  system,
  ...
}:
{
  home.sessionVariables = {
    EDITOR = "hx";
  };
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${system}.helix;
    settings = {
      theme = "catppuccin_mocha";
      editor = import ./editor.nix;
      keys = import ./binds.nix;
    };
    languages = import ./languages.nix { inherit pkgs; };
    themes = import ./theme.nix { inherit config; };
  };
}
