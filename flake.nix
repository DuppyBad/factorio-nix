{
  description = "Factorio HYPERUNSTABLE";

  inputs = {
    nixpkgs.url = "github:Duppybad/nixpkgs"; # pin to master who cares all I need is factorio
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
          ./config.nix
          (import ./services)
        ];
      };
    };
  };
}
