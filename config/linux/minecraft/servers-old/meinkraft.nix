{ servers, mods, pkgs, ... }:
{
  enable = true;
  package = servers.fabric-1_21_3;
  openFirewall = true;
  serverProperties = {
    difficulty = "hard";
    spawn-protection = 0;
    server-port = 25573;
    view-distance = 8;
    online-mode = true;
    motd = "meinkraft";
    white-list = true;
  };
  jvmOpts = "-Xms1024M -Xmx16384M";

  symlinks = {
    mods = pkgs.linkFarmFromDrvs "mods-mein"
      (mods.modrinth-fabric "1.21.3" [
        "appleskin" "servux" # "distanthorizons"
        "lithium"
        "carpet"
        "fabric-api"
      ]);
  };

  whitelist = {
    "softerdrinks" = "2b5c1411-1a8c-42b5-9975-4b65a68beee3";
    "pancakeO_O" = "33fb07d2-bf04-4e98-a967-18fa2005b187";
    "ihydrc" = "4256c0a3-5493-428c-9384-47ec06ec5299";
    "nediaug7" = "8fd6a1d3-9254-4afc-9031-9d1b6b0f9a7a";
    "mofeyyy" = "fa73222c-85dd-4fc9-a2e3-3ce68c063a38";
    "theeallegations" = "7d001155-c8ad-4fd3-862f-12f3c05ead85";
    "icylookbehind" = "1a35bd70-3659-4a39-8e89-13ad38206f71";
    "ASUFUTIMAEHAE" = "4c2e8ce3-ed89-4d58-8dc3-9cc48098de0a";
    "ybgjin" = "cf93b3b4-05df-48de-9ea8-7f444fa50fc3";
    "commandzomb" = "550c676a-ceea-4d81-8966-d1b70f29fbef";
    "andrew2857" = "63027726-74cf-43a0-b3e1-083655683fdd";
    "maoric" = "b9274e68-77a7-4dde-a9d6-f88021e50742";
    "ropi_brian" = "d67005f3-1cf9-4d9a-8709-2ecab23d9bfd";
    "tortory" = "93d41bb3-0da7-409a-ae93-431de19553cc";
    "merdonic" = "d7830081-5a65-41b3-a952-3888223d83b5";
    "yvain" = "0278da5b-a5b7-48bd-beff-23fc8091398b";
    "jeb_namrek" = "31aa81d2-7e78-447a-9444-3e34bd2016ec";
    "p4radux" = "1d489cb8-d688-47d8-944a-77ed297df463";
    "lonepike_11" = "73a43eab-d398-4b0d-85d8-9dfb2e490c2e";
  };
}
