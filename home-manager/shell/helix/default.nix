{
  pkgs,
  config,
  inputs,
  system,
  helpers,
  ...
}:
{
  home.packages = with pkgs; [
    docker-compose-language-service
    dockerfile-language-server-nodejs
    black
    ruff
    nil
    nixfmt-rfc-style
    python312Packages.python-lsp-server
  ];

  xdg.configFile."helix/languages.toml".source = ./languages.toml;
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${system}.helix;
    defaultEditor = true;
    settings = {
      theme = "paradise";
      editor = import ./editor.nix;
      keys = import ./binds.nix;
    };
    themes = import ./theme.nix {
      inherit config;
      inherit (helpers) mkHex;
    };
  };
}
