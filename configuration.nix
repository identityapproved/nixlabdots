{ ... }:

let
  sshKeys = import ./secrets/ssh-keys.nix;
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/base.nix
    ./modules/boot.nix
    ./modules/neovim.nix
    ./modules/networking.nix
    ./modules/shell.nix
    ./modules/packages.nix
    ./modules/tmux.nix
    ./modules/ssh.nix
    ./modules/wifi.nix
    ./modules/docker.nix
    ./modules/k3s.nix
  ];

  users.users.identityapproved.openssh.authorizedKeys.keys = sshKeys;

  system.stateVersion = "25.05";
}
