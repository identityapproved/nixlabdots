{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 3232 ];
    openFirewall = true;

    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PubkeyAuthentication = false;
      AllowUsers = [ "identityapproved" ];
      # UseDns = true;
      X11Forwarding = false;
    };
  };
}
