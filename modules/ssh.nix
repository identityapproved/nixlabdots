{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 3232 ];
    openFirewall = true;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
      AllowUsers = [ "identityapproved" ];
      # UseDns = true;
      X11Forwarding = false;
    };
  };
}
