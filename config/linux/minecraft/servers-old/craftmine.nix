{ servers, ... }:
{
  enable = false;
  package = servers.vanilla-25w14craftmine;
  openFirewall = true;
  serverProperties = {
    difficulty = "hard";
    spawn-protection = 0;
    server-port = 25571;
    view-distance = 16;
    online-mode = true;
    motd = "craftmine";
  };
  jvmOpts = "-Xms1024M -Xmx4096M";
}
