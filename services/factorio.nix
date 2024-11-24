{
  pkgs,
  lib,
  self,
  ...
}: {
  services.factorio = {
    enable = true;
    openFirewall = true; #shorthand for networking.firewall.allowedUDPPorts
    description = "Tinybrain gaming?";
    game-name = "TinyFactory";
    admins = ["ExKyrios"];
    loadLatestSave = true;
    requireUserVerification = true;
    nonBlockingSaving = true;
    /*
       mods = let
      # I wish I had |> but no pipe operator here
      inherit (pkgs) lib;
      modDir = ../mods;
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
    */
  };
}
