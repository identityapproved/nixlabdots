{ ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    terminal = "tmux-256color";
    extraConfig = ''
      # Forward clipboard operations to the local terminal over SSH.
      set -s set-clipboard on
      set -g allow-passthrough on
      set -as terminal-features ',*:clipboard'
    '';
  };
}
