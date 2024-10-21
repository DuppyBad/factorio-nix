{
  description = "Factorio Headless Server Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Use the unstable channel for the latest packages
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations = {
      factorio-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Specify your system architecture
        modules = [
          ./factorio.nix
        ];
      };
    };
  };
}
