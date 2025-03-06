{
  description = "my flake";

  nixConfig = {
    extra-substituters =
      [ "https://helix.cachix.org" "https://nixpkgs-wayland.cachix.org" ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix";
    rust-overlay = {
      url =
        "github:oxalica/rust-overlay?rev=9a55a224af34b4f74526c261aeccd8d40af5e4f2";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, nix-colors, ... }@inputs:
    let
      system = "x86_64-linux";
      overlaysSettings = {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
          allowInsecurePredicate = _: true;
        };
        overlays = [
          inputs.nixpkgs-wayland.overlay
          (self: super: {
            fish = inputs.nixpkgs-master.legacyPackages.${system}.fish;
          })
        ];
      };
      pkgs = import nixpkgs overlaysSettings;
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = { inherit inputs system nix-colors; };
        modules = [
          ./lib/theme.nix
          ./nixos/configuration.nix
          inputs.disko.nixosModules.default
          (import ./disko.nix { device = "/dev/nvme0n1"; })
        ];
      };

      formatter.${system} = pkgs.nixfmt-classic;

      homeConfigurations.krabodyan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager ./lib/theme.nix ./lib/helpers.nix ];
      };

      devShells.${system} = let
        rust-pkg = (import nixpkgs {
          inherit system;
          overlays = [ (import inputs.rust-overlay) ];
        }).rust-bin.nightly.latest.default.override {
          targets = [ "wasm32-unknown-unknown" "x86_64-unknown-linux-gnu" ];
          extensions = [ "rust-src" "rust-analyzer" "miri" ];
        };
        shellHook = # bash
          ''test -n "$TMUX" || tmux'';
      in {
        rust = pkgs.mkShell {
          inherit shellHook;
          DEV_SHELL_NAME = "rust";
          RUST_BACKTRACE = 1;
          nativeBuildInputs = with pkgs; [
            pkg-config
            cargo-watch
            cargo-expand
          ];
          buildInputs = with pkgs; [ rust-pkg openssl ];
        };
        tauri = pkgs.mkShell {
          inherit shellHook;
          DEV_SHELL_NAME = "tauri";
          RUST_BACKTRACE = 1;
          GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
          nativeBuildInputs = with pkgs; [
            sqlx-cli
            cargo-watch
            cargo-expand
            cargo-tauri
            dioxus-cli
            wasm-bindgen-cli
            pkg-config
            gobject-introspection
            nodejs
            tailwindcss
            # trunk # for wasm
          ];
          buildInputs = with pkgs; [
            sqlite.dev
            rust-pkg
            openssl
            at-spi2-atk
            xdotool
            openssl.dev
            atkmm
            cairo
            gdk-pixbuf
            glib
            gtk3
            harfbuzz
            librsvg
            libsoup_3
            pango
            webkitgtk_4_1
          ];
        };
        ino = pkgs.mkShell {
          DEV_SHELL_NAME = "ino";
          buildInputs = [ pkgs.glibc_multi ];
          inherit shellHook;
        };
        python = pkgs.mkShell {
          inherit shellHook;
          DEV_SHELL_NAME = "python";
          packages = [
            (pkgs.python311.withPackages (python-pkgs:
              with python-pkgs; [
                numpy
                tkinter
                matplotlib
                # (buildPythonPackage rec {
                #   pname = "idx2numpy";
                #   version = "1.2.3";
                #   src = fetchPypi {
                #     inherit pname version;
                #     sha256 =
                #       "sha256-VZtXio9ppBr1TPFcjfxDq584Dgp9YCqEvauvUqz7vT4=";
                #   };
                #   doCheck = false;
                # })
              ]))
          ];
        };
      };
    };
}
