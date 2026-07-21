{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "random";
      plugins = [
        "git"
        "rust"
        "history"
        "python"
        "zoxide"
        "docker"
        "tmux"
        "docker-compose"
      ];
    };

    loginShellInit = ''
      # Auto-start tmux on login (SSH or TTY)
      if command -v tmux >/dev/null 2>&1; then
        if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
          exec tmux new-session -A -s main
        fi
      fi
    '';
  };

  users.defaultUserShell = pkgs.zsh;
}
