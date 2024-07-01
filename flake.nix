{
  description = "krabodyan system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nixvim = {
    #  type  = "github";
    #  owner = "nix-community";
    #  repo  = "nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
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
          #inputs.nixvim.homeManagerModules.nixvim
        ];
      };
    };
}
