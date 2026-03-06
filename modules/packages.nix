{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    vim
    zoxide
    curl
    wget
    htop
    bat
    ripgrep
    fd
    tmux
    tree
    lazydocker
    ethtool
    iw
  ];
}
