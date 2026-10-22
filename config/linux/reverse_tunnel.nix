{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.minecraft-tunnel;
in
{
  options.services.minecraft-tunnel = {
    enable = mkEnableOption "Minecraft SSH Reverse Tunnel";

    localPort = mkOption {
      type = types.port;
      default = 25565;
      description = "Local Minecraft server port.";
    };

    vpsPort = mkOption {
      type = types.port;
      default = 25566;
      description = "Port on the VPS to forward from.";
    };

    vpsIp = mkOption {
      type = types.str;
      description = "Public IP address or hostname of the VPS.";
      example = "203.0.113.50";
    };

    vpsUser = mkOption {
      type = types.str;
      default = "tunnel_user";
      description = "SSH user on the VPS.";
    };

    identityFile = mkOption {
      type = types.str; # Using str instead of path to avoid copying secrets to the Nix store
      description = "Absolute path to the SSH private key.";
      example = "/home/youruser/.ssh/vps_tunnel_key";
    };

    user = mkOption {
      type = types.str;
      description = "Local user to run the SSH tunnel service.";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.minecraft-tunnel = {
      description = "Minecraft SSH Reverse Tunnel";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = cfg.user;
        Restart = "always";
        RestartSec = "5";
        # StrictHostKeyChecking=accept-new prevents the service from hanging
        # when connecting to the VPS for the very first time.
        ExecStart = ''
          ${pkgs.openssh}/bin/ssh -N -T \
            -R ${toString cfg.vpsPort}:localhost:${toString cfg.localPort} \
            -i ${cfg.identityFile} \
            -o StrictHostKeyChecking=accept-new \
            -o ExitOnForwardFailure=yes \
            -o ServerAliveInterval=60 \
            -o ServerAliveCountMax=3 \
            ${cfg.vpsUser}@${cfg.vpsIp}
        '';
      };
    };
  };
}
