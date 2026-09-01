{ inputs, ... }:
{
  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

  networking.firewall.allowedTCPPorts = [ 3923 ];
  networking.firewall.allowedUDPPorts = [ 3923 ];

  services.copyparty = {
    enable = true;

    settings = {
      i = "0.0.0.0";

      dedup = true;
      e2dsa = true;
      e2ts = true;
      reflink = true;
    };

    accounts = {
      noob.passwordFile = "/home/danielgu/.config/copyparty/.pw_noob";
      maimai.passwordFile = "/home/danielgu/.config/copyparty/.pw_maimai";
      upload.passwordFile = "/home/danielgu/.config/copyparty/.pw_upload";
      outreach.passwordFile = "/home/danielgu/.config/copyparty/.pw_outreach";
    };

    volumes."/storage" = {
      path = "/srv/copyparty/storage";

      access.A = [ "noob" ];

      flags = {
        scan = 60 * 5;
        norobots = true;
      };
    };

    volumes."/maicharts" = {
      path = "/srv/copyparty/maicharts";

      access.r = "maimai";
      access.A = [ "noob" ];

      flags.dlni = true;
    };

    volumes."/tmp" = {
      path = "/srv/copyparty/tmp";

      access.wG = "*";
      access.A = [ "noob" ];

      flags = {
        fk = 4;
        sz = "0b-1g";
        d2t = true;
        lifetime = 24 * 60 * 60;
      };
    };

    volumes."/share" = {
      path = "/srv/copyparty/share";

      access.rg = "*";
      access.A = [ "noob" ];

      flags = {
        d2t = true;
        lifetime = 24 * 60 * 60;
      };
    };

    volumes."/outreach" = {
      path = "/srv/copyparty/outreach";

      access.rwg = "outreach";
      access.A = [ "noob" ];
    };

    openFilesLimit = 8192;
  };
}
