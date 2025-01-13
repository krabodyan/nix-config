{
  description = "my flake";

  nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      # "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      # "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # yazi.url = "github:sxyazi/yazi";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.nixpkgs-wayland.overlay ];
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self system inputs; };
        modules = [
          ./lib/theme.nix
          ./nixos/configuration.nix
          inputs.disko.nixosModules.default
          (import ./disko.nix { device = "/dev/nvme0n1"; })
        ];
      };

      homeConfigurations.krabodyan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit self system inputs;
          helpers = import ./lib/helpers.nix;
        };
        modules = [ ./home-manager ];
      };

      devShells.${system} = let
        rust-pkg = (import nixpkgs {
          inherit system;
          overlays = [ (import inputs.rust-overlay) ];
        }).rust-bin.nightly.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "miri" ];
        };
      in {
        rust = pkgs.mkShell {
          DEV_SHELL_NAME = "rust";
          RUST_BACKTRACE = 1;
          nativeBuildInputs = with pkgs; [ pkg-config ];
          buildInputs = with pkgs; [
            rust-pkg
            openssl
            # llvmPackages.clang
            # alsa-lib
            # libpulseaudio
            # postgresql
            # fontconfig
          ];
          # LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
        };
        tauri = pkgs.mkShell {
          DEV_SHELL_NAME = "tauri";
          RUST_BACKTRACE = 1;
          GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
          nativeBuildInputs = with pkgs; [
            pkg-config
            gobject-introspection
            cargo-tauri
            nodejs
            svelte-language-server
            typescript-language-server
          ];
          buildInputs = with pkgs; [
            rust-pkg
            openssl
            at-spi2-atk
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
        python = pkgs.mkShell {
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
