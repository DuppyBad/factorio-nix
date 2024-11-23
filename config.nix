{
  config,
  pkgs,
  inputs,
  self,
  ...
}: {
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
  boot.loader.grub.device = "/dev/sda";
}
