{
  self,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    # ./mc-servers
    ../../config/linux/locale.nix
    ../common.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "pzn";
  networking.hosts = {
    "192.168.100.200" = [ "pzn.local" ];
    "192.168.100.1" = [ "ddwrt.local" ];
    "223.166.245.202" = [ "home" ];
  };

  users.users.pansternoob = {
    isNormalUser = true;
    description = "Panster Noob";
    extraGroups = [
      "networkmanager"
      "wheel"
      "minecraft"
    ];
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = { inherit self inputs; };
    users = {
      "pansternoob" = import ./home.nix;
    };
    backupFileExtension = "bak";
  };

  services.openssh.enable = true;

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = true;
    settings = null;
  };

  environment.systemPackages = with pkgs; [
    xclip
    nushell
  ];
  environment.enableAllTerminfo = true;
  environment.shells = [
    "/run/current-system/sw/bin/nu"
    "${pkgs.nushell}/bin/nu"
  ];

  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  system.stateVersion = "23.11";
}
