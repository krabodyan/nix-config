{
  lib,
  pkgs,
  config,
  colors,
  inputs,
  hostname,
  mkAssociations,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption mkMerge;
  cfg = config.module.helix;
in {
  options = {
    module.helix = {
      enable = mkEnableOption "helix";
      webSupport = mkOption {
        type = lib.types.bool;
        example = "true";
        default = false;
      };
      devopsSupport = mkOption {
        type = lib.types.bool;
        example = "true";
        default = false;
      };
    };
  };
  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      package = inputs.helix.packages.${pkgs.system}.helix;

      extraPackages = with pkgs;
        mkMerge [
          [
            docker-compose-language-service
            dockerfile-language-server-nodejs

            taplo
            biome
            yaml-language-server

            shfmt
            fish-lsp
            just-lsp
            bash-language-server

            just-lsp
            just-formatter

            ty
            pyright
            ruff

            sqlfluff
            clang-tools
            vscode-langservers-extracted
            nodePackages.prettier

            (import ./yazi-picker.nix {inherit pkgs;})
          ]
          (mkIf
            cfg.webSupport [
              tailwindcss-language-server
              typescript-language-server
              svelte-language-server
              nodejs-slim
            ])
          (mkIf
            cfg.devopsSupport [
              nginx-language-server
              nginx-config-formatter
              terraform-ls
            ])
        ];

      settings = {
        theme = "paradise";
        editor = import ./editor.nix;
        keys = import ./binds.nix;
      };

      themes = import ./theme.nix {inherit colors;};

      languages = import ./languages.nix {inherit lib pkgs hostname;};

      ignores = let
        add_ignore = ext: "*.${ext}";
      in
        config.programs.git.ignores
        ++ [
          "*.lock"
          "package-lock.json"
        ]
        ++ map add_ignore [
          "png"
          "svg"
          "jpeg"
          "jpg"
          "ttf"
          # --end media formats
          "doc"
          "docx"
          "pptx"
          "xls"
          "xlsx"
          # --end office
          "csv"
          "drawio"
        ];
    };

    xdg.mimeApps.defaultApplications = mkAssociations {
      types = [
        "text/plain"
        "text/markdown"
        "text/x-markdown"
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
        "text/rhtml"
        "text/x-tex"
        "text/x-java"
        "text/x-ruby"
        "inode/x-empty"
        "text/x-readme"
        "application/json"
        "application/x-ruby"
        "application/x-yaml"
        "application/x-shellscript"
        "application/x-docbook+xml"
      ];
      desktop = "Helix.desktop";
    };
  };
}
