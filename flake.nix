{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
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

    helix = {
      url = "github:helix-editor/helix";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay?rev=fd6795d3d28f956de01a0458b6fa7baae5c793b4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    nix-cursors = {
      url = "github:krabodyan/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fish-done = {
      url = "github:krabodyan/fish-done-osc99";
      flake = false;
    };

    yazi-plugin-ouch = {
      url = "github:ndtoan96/ouch.yazi";
      flake = false;
    };

    yazi-plugin-rsync = {
      url = "github:krabodyan/rsync.yazi";
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
      systems = ["x86_64-linux"];
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
