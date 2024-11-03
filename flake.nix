{
  description = "Dual Package Factorio";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    garnix-lib.url = "github:garnix-io/garnix-lib";
  };

  outputs = {
    self,
    nixpkgs,
    garnix-lib,
    nixpkgs-unstable,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable-legacy = pkgs-unstable.legacyPackages.${system};

  in {
    nixosConfigurations = {
      factorio-server = lib.nixosSystem {
        inherit system;
        modules = [
          ./config.nix
          ./factorio.nix
          garnix-lib.nixosModules.garnix
        ];
        specialArgs = {
          inherit pkgs-unstable;
          inherit pkgs-unstable-legacy;
        };
      };
    };
  };
}
