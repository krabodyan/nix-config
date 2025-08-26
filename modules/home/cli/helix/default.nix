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
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.helix;
in {
  options = {
    module.helix = {
      enable = mkEnableOption "helix";
      components = mkOption {
        type = lib.types.listOf (lib.types.enum ["base" "web" "devops" "sql" "cpp"]);
        default = [];
        example = ["base" "web" "devops" "sql" "cpp"];
      };
    };
  };
  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      package = inputs.helix.packages.${pkgs.system}.helix;

      extraPackages = with pkgs; let
        components = {
          base = [
            docker-compose-language-service
            dockerfile-language-server-nodejs

            taplo
            biome
            yaml-language-server

            shfmt
            fish-lsp
            bash-language-server

            just-lsp
            just-formatter

            ty
            pyright
            ruff

            vscode-langservers-extracted
            nodePackages_latest.prettier
          ];

          web = [
            # tailwindcss-language-server
            typescript-language-server
            # svelte-language-server
          ];

          cpp = [
            cmake-language-server
            cmake-format
            clang-tools
          ];

          sql = [
            sqlfluff
            sqls
          ];

          devops = [
            nginx-language-server
            nginx-config-formatter
            terraform-ls
          ];
        };
      in
        lib.flatten (map (component: components.${component}) cfg.components)
        ++ [
          (import ./yazi-picker.nix {inherit pkgs;})
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
