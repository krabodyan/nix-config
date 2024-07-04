{
  description = "krabodyan system configuration";

  nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    helix.url = "github:helix-editor/helix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self system inputs; };
        modules = [
          ./nixos/configuration.nix
          inputs.disko.nixosModules.default
          (import ./disko.nix { device = "/dev/sda"; })
        ];
      };
      homeConfigurations.krabodyan = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit system inputs; };
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
}
