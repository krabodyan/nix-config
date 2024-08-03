{
  description = "my flake";

  nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
      "https://mur.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "mur.cachix.org-1:VncNRWnvAh+Pl71texI+mPOiwTB5267t029meC4HBC0="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ayugram-pkgs = {
      url = "github:duvetfall/mur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlays = [ (import inputs.rust-overlay) ];
      pkgs = import nixpkgs { inherit system overlays; };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit self system inputs;
        };
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
          inherit system inputs;
          helpers = import ./lib/helpers.nix;
        };
        modules = [ ./home-manager ];
      };

      devShells.${system} = {
        default =
          let
            rust = pkgs.rust-bin.nightly.latest.default.override {
              extensions = [
                "rust-src"
                "rust-analyzer"
              ];
            };
          in
          pkgs.mkShell {
            buildInputs =
              [ rust ]
              ++ (with pkgs; [
                pkg-config
                openssl
              ]);
            PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
            RUST_BACKTRACE = 1;
          };

        python = pkgs.mkShell {
          packages = [
            (pkgs.python3.withPackages (
              ps: with ps; [
                libtorrent-rasterbar
                requests
                aiogram
              ]
            ))
          ];
        };
      };
    };
}
