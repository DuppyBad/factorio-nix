{
  description = "Factorio HYPERUNSTABLE";

  inputs = {
    nixpkgs.url = "github:graysonhead/nixpkgs"; # Use the unstable channel for the latest packages
    garnix-lib.url = "github:garnix-io/garnix-lib";
  };

  outputs = {
    self,
    nixpkgs,
    garnix-lib,
    ...
  } @ inputs: {
    nixosConfigurations = {
      factorio-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Specify your system architecture
        modules = [
          inputs.garnix-lib.nixosModules.garnix
          ./factorio.nix
          ./config.nix
        ];
      };
    };
  };
}
