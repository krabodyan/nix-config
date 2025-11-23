{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-pinned = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "2fb006b87f04c4d3bdf08cfdbc7fab9c13d94a15";
      narHash = "sha256-kJ8lIZsiPOmbkJypG+B5sReDXSD1KGu2VEPNqhRa/ew=";
    };

    rust-overlay = {
      type = "github";
      owner = "oxalica";
      repo = "rust-overlay";
      rev = "63d22578600f70d293aede6bc737efef60ebd97f";
      narHash = "sha256-Zo3LQQDz+64EQ9zor/WmeNTFLoZkjmhp0UY3G0D3seE=";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix";
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

    sshfs-yazi = {
      url = "github:uhs-robert/sshfs.yazi";
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
    overlays = [(import ./overlays {inherit inputs;}).overlay];
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        inputs.treefmt-nix.flakeModule
        ./parts/devshells
        ./parts/treefmt
      ];

      perSystem = {system, ...}: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system overlays;
        };
      };

      flake = {
        inherit overlays;
        nixosConfigurations = libx.genNixos hosts;
        homeConfigurations = libx.genHome hosts;
      };
    };
}
