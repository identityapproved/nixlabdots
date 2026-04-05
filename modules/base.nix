{ pkgs, ... }:

{
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Kyiv";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  services.getty.autologinUser = "identityapproved";
  services.systemd-oomd.enable = true;

  users.users.identityapproved = {
    isNormalUser = true;
    description = "identityapproved";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
