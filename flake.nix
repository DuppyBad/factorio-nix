{
  description = "Factorio Headless Server Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Use the unstable channel for the latest packages
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      factorio-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";  # Specify your system architecture
        modules = [
          {
            # Factorio headless server setup

            environment.systemPackages = with pkgs; [
              factorio-headless
            ];
            nixpkgs.config.allowUnfree = true;
            services.factorio = {
              enable = true;
              openFirewall = true;
            };
            # Open the default Factorio port in the firewall

            # Optional: Enable SSH for remote management
            services.openssh.enable = true;
          }
        ];
      };
    };
  };
}

