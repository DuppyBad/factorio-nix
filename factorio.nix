{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    factorio-headless
  ];

  services.factorio = {
    enable = true;
    openFirewall = true;
  };
}
