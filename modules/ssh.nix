{ ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 3232 ];
    openFirewall = true;

    settings = {
      AllowUsers = [ "identityapproved" ];
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
      AuthenticationMethods = "publickey";
      X11Forwarding = false;
      AllowAgentForwarding = false;
      AllowTcpForwarding = false;
      PermitTunnel = false;
      AllowStreamLocalForwarding = false;
      MaxAuthTries = 3;
      MaxSessions = 2;
      LoginGraceTime = "30s";
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
      UseDns = false;
      PrintMotd = false;
  };
};
}
