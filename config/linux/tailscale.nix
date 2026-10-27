{ ... }:
{
  services.tailscale = {
    enable = true;
    # Opens UDP 41641 so peers can connect directly instead of through a DERP relay
    openFirewall = true;
  };

  # sshd already listens on all interfaces, so `ssh danielgu@fwd-nixos` works over the tailnet.
  # Trusting the interface also lets other tailnet-only services through the firewall.
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
