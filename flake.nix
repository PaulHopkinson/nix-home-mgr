{
  description = "Home Manager configuration for Paul";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "paul";
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          ./home.nix
        ];
      };
    };
}

