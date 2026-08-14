{ ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    terminal = "tmux-256color";
    keyMode = "vi";          # mode-keys vi for copy-mode nav
    historyLimit = 50000;    # bigger scrollback since tmux owns the screen
    escapeTime = 10;         # snappier nvim/esc over SSH (default is 500)
    extraConfig = ''
      # Wheel scrolls pane history; drag selects. This is the scroll fix.
      set -g mouse on

      # Clipboard -> local terminal over SSH via OSC 52 (your original lines).
      set -s set-clipboard on
      set -g allow-passthrough on
      set -as terminal-features ',*:clipboard'

      # vi copy-mode: selection + copy. copy-selection-and-cancel emits OSC 52
      # because of set-clipboard on above, so it lands in your LOCAL clipboard.
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-selection-and-cancel
    '';
  };
}
