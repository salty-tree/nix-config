{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        serverAliveInterval = 60;
      };

      "nixos-cf" = {
        hostname = "ssh.giantsaltytree.com";
        user = "danielgu";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };

      "lambda" = {
        hostname = "lambda.cs.illinois.edu";
        user = "danielg";
        localForwards = [
          {
            bind.port = 27180;
            host.address = "localhost";
            host.port = 27180;
          }
        ];
      };

      "willserver" = {
        hostname = "irs.willkurr.com";
        user = "irsadmin";
      };

      "vps" = {
        hostname = "24.199.75.76";
        user = "root";
      };
    };
  };
}
