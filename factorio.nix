{
  pkgs,
  config,
  inputs,
  new,
  ...
}: let
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBU9ecVSTJ6nbhXtJS6A/yutUhOAom+OSVU8SBzayHFf kyrios@machina"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjuzWXJAxCMhRiEvNneHD4iR8hQVR2S0pGK40ogWoWH kyrios@mekhanes"
  ];

in {
  garnix.server.enable = true;
  nixpkgs.config.allowUnfree = true;
  services = {
    openssh.enable = true;
    factorio = {
      enable = true;
      openFirewall = true; #shorthand for networking.firewall.allowedUDPPorts
      description = "Tinybrain gaming?";
      game-name = "TinyFactory";
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
    new.factorio-headless
    htop
    bottom
  ];
}
