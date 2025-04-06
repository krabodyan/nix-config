{
  description = "my flake";

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

    rust-overlay.url = "github:oxalica/rust-overlay?rev=f03085549609e49c7bcbbee86a1949057d087199";

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    nix-colors.url = "github:misterio77/nix-colors";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Mic92/sops-nix";
    };

    fish-done = {
      url = "github:krabodyan/fish-done-osc99";
      flake = false;
    };
    yazi-plugin-compress = {
      url = "github:KKV9/compress.yazi";
      flake = false;
    };
    yazi-plugin-ouch = {
      url = "github:ndtoan96/ouch.yazi";
      flake = false;
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
        inputs.treefmt-nix.flakeModule
        ./parts/devshells
        ./parts/treefmt
      ];
      flake = {
        nixosConfigurations = libx.genNixos hosts;
        homeConfigurations = libx.genHome hosts;
      };
    };
}
