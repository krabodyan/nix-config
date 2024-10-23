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
    vscode-langservers-extracted
    nixfmt-rfc-style
    python312Packages.python-lsp-server
  ];

  xdg.desktopEntries."Helix" = {
    name = "Helix";
    exec = "foot hx %F";
  };

  xdg.mimeApps.defaultApplications = helpers.mkAssociations {
    types = [
      "text/plain"
      "application/rust"
      "text/rust"
      "application/toml"
      "text/x-python"
      "application/sql"
      "text/x-csrc"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/comma-separated-values"
      "text/csv"
    ];
    desktop = "Helix.desktop";
  };

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
