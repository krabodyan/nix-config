{ pkgs, theme, inputs, helpers, ... }: {
  home.packages = with pkgs; [
    docker-compose-language-service
    dockerfile-language-server-nodejs
    black
    biome
    ruff
    nixd
    vscode-langservers-extracted
    nixfmt-classic
    python312Packages.python-lsp-server
    typescript-language-server
    nodePackages.prettier
    (import ./yazi-picker.nix { inherit pkgs; })
  ];

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
      "text/x-cmake"
      "text/markdown"
      "text/rhtml"
      "text/x-tex"
      "text/x-java"
      "text/x-ruby"
      "inode/x-empty"
      "text/x-readme"
      "text/x-markdown"
      "application/json"
      "application/x-ruby"
      "application/x-yaml"
      "application/x-shellscript"
      "application/x-docbook+xml"
    ];
    desktop = "Helix.desktop";
  };

  xdg.configFile."helix/languages.toml".source = ./languages.toml;
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.helix;
    defaultEditor = true;
    settings = {
      theme = "paradise";
      editor = import ./editor.nix;
      keys = import ./binds.nix;
    };
    themes = import ./theme.nix {
      inherit theme;
      inherit (helpers) mkHex;
    };
    ignores = let add_ignore = ext: "*.${ext}";
    in [ "target" "icons" "venv" "node_modules" "__pycache__" "build" ]
    ++ map add_ignore [
      "png"
      "svg"
      "jpeg"
      "jpg"
      "mov"
      "mp4"
      "mkv"
      "mp4"
      "ttf"
      # --end media formats
      "doc"
      "docx"
      "pptx"
      "xls"
      "xlsx"
      # --end office
      "pdf"
      "csv"
      "drawio"
    ];
  };
}
