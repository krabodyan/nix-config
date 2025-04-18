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

    rust-overlay.url = "github:oxalica/rust-overlay?rev=fd6795d3d28f956de01a0458b6fa7baae5c793b4";

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    nix-colors.url = "github:misterio77/nix-colors";

    nix-cursors = {
      url = "github:krabodyan/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
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
