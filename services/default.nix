{
  self,
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./system.nix
    ./factorio.nix
  ];
}
