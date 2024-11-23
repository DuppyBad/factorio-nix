{
  inputs,
  pkgs,
  lib,
  config,
  self,
  ...
}: let
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBU9ecVSTJ6nbhXtJS6A/yutUhOAom+OSVU8SBzayHFf kyrios@machina"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjuzWXJAxCMhRiEvNneHD4iR8hQVR2S0pGK40ogWoWH kyrios@mekhanes"
  ];
in {
  garnix = {
    server = {
      enable = true;
      persistence = {
        enable = true;
        name = "factorio";
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
  services = {
    openssh.enable = true;
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
}
