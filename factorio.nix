{
  pkgs,
  lib,
  config,
  inputs,
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
    factorio = {
      enable = true;
      openFirewall = true; #shorthand for networking.firewall.allowedUDPPorts
      description = "Tinybrain gaming?";
      game-name = "TinyFactory";
      admins = ["ExKyrios"];
      loadLatestSave = true;
      requireUserVerification = true;
      nonBlockingSaving = true;
      mods = let
        # I wish I had |> but no pipe operator here
        inherit (pkgs) lib;
        modDir = self.mods;
        modList = lib.pipe modDir [
          builtins.readDir
          (lib.filterAttrs (k: v: v == "regular"))
          (lib.mapAttrsToList (k: v: k))
          (builtins.filter (lib.hasSuffix ".zip"))
        ];
        modToDrv = modFileName:
          pkgs.runCommand "copy-factorio-mods" {} ''
            mkdir $out
            cp ${modDir + "/${modFileName}"} $out/${modFileName}
          ''
          // {deps = [];};
      in
        builtins.map modToDrv modList;
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
}
