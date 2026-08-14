{ pkgs, ... }:

let
  mgmtInterface = "enp0s21f0u2u4";
  wifiInterface = "wlo1";
in
{
  # Keep the wired management path simple: DHCP on the USB Ethernet NIC.
  # Reserve the address on OpenWrt instead of hardcoding it here.
  networking.networkmanager.unmanaged = [ "interface-name:${wifiInterface}" ];

  services.udev.extraRules = ''
  SUBSYSTEM=="net", ACTION=="add", DRIVERS=="mt76x2u", NAME="netgear_"
  '';

  environment.systemPackages = with pkgs; [
    jq
    yq-go
    btop
    eza
    iproute2
    iputils
    usbutils
    pciutils
    lsof
    util-linux
    wirelesstools
    hostapd-mana
    aircrack-ng
    hcxdumptool
    hcxtools
    tcpdump
    tshark
    termshark
    hashcat
  ] ++ [
    (pkgs.writeShellScriptBin "wifi-info" ''
      set -eu

      echo "== ip -br address =="
      ip -br address || true
      echo
      echo "== management carrier (${mgmtInterface}) =="
      ip -br link show "${mgmtInterface}" || true
      echo
      echo "== iw dev =="
      iw dev || true
      echo
      echo "== rfkill =="
      rfkill list || true
    '')

    (pkgs.writeShellScriptBin "wifi-mon-up" ''
      set -eu
      iface="''${1:-${wifiInterface}}"

      ip link set "$iface" down
      iw dev "$iface" set type monitor
      ip link set "$iface" up

      echo "[+] $iface is now in monitor mode"
      iw dev "$iface" info
    '')

    (pkgs.writeShellScriptBin "wifi-mon-down" ''
      set -eu
      iface="''${1:-${wifiInterface}}"

      ip link set "$iface" down
      iw dev "$iface" set type managed
      ip link set "$iface" up

      echo "[+] $iface is now back in managed mode"
      iw dev "$iface" info
    '')
  ];

  systemd.tmpfiles.rules = [
    "d /srv/wifi 0750 identityapproved users - -"
    "d /srv/wifi/captures 0750 identityapproved users - -"
    "d /srv/wifi/handshakes 0750 identityapproved users - -"
    "d /srv/wifi/wordlists 0750 identityapproved users - -"
    "d /srv/wifi/logs 0750 identityapproved users - -"
  ];
}
