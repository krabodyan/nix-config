{
  description = "my flake";

  # nixConfig = {
  #   extra-substituters = ["https://helix.cachix.org" "https://nixpkgs-wayland.cachix.org"];
  #   extra-trusted-public-keys = [
  #     "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
  #     "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
  #   ];
  # };

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
    rust-overlay.url = "github:oxalica/rust-overlay?rev=9a55a224af34b4f74526c261aeccd8d40af5e4f2";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nix-colors.url = "github:misterio77/nix-colors";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs: let
    libx = import ./lib {inherit self inputs;};
    hosts = import ./hosts.nix;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = libx.forAllSystems;
      imports = [
        inputs.home-manager.flakeModules.home-manager
        ./parts
      ];
      flake = {
        nixosConfigurations = libx.genNixos hosts;
        homeConfigurations = libx.genHome hosts;
      };
    };
}
