{
  description = "my flake";

  nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
      "https://kaeeraa.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "kaeeraa.cachix.org-1:S3CnhT12akYQf4Ph7fndLgqo2os4ket3OTP2amrzJRs="
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
    ayugram-desktop.url = "git+https://github.com/kaeeraa/ayugram-desktop?submodules=1";
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
      pkgs = import nixpkgs { inherit system; };
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
            overlays = [ (import inputs.rust-overlay) ];
            pkgs = import nixpkgs { inherit system overlays; };
            rust = pkgs.rust-bin.nightly.latest.default.override {
              extensions = [
                "rust-src"
                "rust-analyzer"
              ];
            };
          in
          pkgs.mkShell {
            buildInputs = [ rust ];
            nativeBuildInputs = with pkgs; [
              pkg-config
              openssl.dev
              alsa-lib.dev
              libpulseaudio.dev
            ];
            RUST_BACKTRACE = 1;
          };
      };
    };
}
