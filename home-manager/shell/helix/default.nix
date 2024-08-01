{
  pkgs,
  config,
  inputs,
  system,
  helpers,
  ...
}:
{
  home.sessionVariables = {
    EDITOR = "hx";
  };
  # home.packages = with pkgs; [ rust-analyzer ];
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${system}.helix;
    settings = {
      theme = "catppuccin_mocha";
      editor = import ./editor.nix;
      keys = import ./binds.nix;
    };
    languages = import ./languages.nix { inherit pkgs; };
    themes = import ./theme.nix {
      inherit config;
      mkHex = helpers.mkHex;
    };
  };
}
