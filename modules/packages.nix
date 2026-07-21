{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
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
    nil
    pyright
    bash-language-server
    marksman
  ];
}
