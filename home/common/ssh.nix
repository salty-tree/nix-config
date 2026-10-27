{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # Keys are OpenSSH directive names, see ssh_config(5)
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        ServerAliveInterval = 60;
      };

      "nixos-cf" = {
        HostName = "ssh.giantsaltytree.com";
        User = "danielgu";
        ProxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };

      "lambda" = {
        HostName = "lambda.cs.illinois.edu";
        User = "danielg";
        LocalForward = [
          {
            bind.port = 27180;
            host.address = "localhost";
            host.port = 27180;
          }
        ];
      };

      "willserver" = {
        HostName = "irs.willkurr.com";
        User = "irsadmin";
      };

      "vps" = {
        HostName = "24.199.75.76";
        User = "root";
      };
    };
  };
}
