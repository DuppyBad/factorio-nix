{
  pkgs,
  config,
  inputs,
  ...
}: let
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBU9ecVSTJ6nbhXtJS6A/yutUhOAom+OSVU8SBzayHFf kyrios@machina"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjuzWXJAxCMhRiEvNneHD4iR8hQVR2S0pGK40ogWoWH kyrios@mekhanes"
  ];

  host = "factorio-server.main.factorio-nix.DuppyBad.garnix.me"; # For self-references in web hosting
in {
  garnix.server.enable = true;
  nixpkgs.config.allowUnfree = true;
  services = {
    openssh.enable = true;
    factorio = {
      enable = true;
      openFirewall = true;
      description = "Tinybrain gaming?";
      game-name = "TinyFactory";
    };
    searx = {
      enable = true;
      settings = {
        server.port = 8080;
        server.bind_address = "127.0.0.1";
        server.secret_key = "secret";
      };
    };
    nginx = {
      enable = true;
      virtualHosts."${host}" = {
        locations."/".proxyPass = "http://localhost:8080";
      };
    };
  };

  users.users.me = {
    isNormalUser = true;
    description = "me";
    extraGroups = ["wheel" "systemd-journal"];
    openssh.authorizedKeys.keys = sshKeys;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    factorio-headless
    htop
    bottom
  ];
  networking.firewall.allowedUDPPorts = [34197]; #Just in case, will check later if needed
  networking.firewall.allowedTCPPorts = [80 443];
}
