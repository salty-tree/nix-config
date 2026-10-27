{
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../../config/darwin/homebrew.nix
    ../../config/darwin/tailscale.nix
    ../../config/fonts.nix
    ../common.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.overlays = [
    (final: prev: { firefox-esr = throw "debug"; })
    (self: super: {
      # fish = super.fish.overrideAttrs (old: {
      #   doCheck = !super.stdenv.hostPlatform.isDarwin;
      # });
      # gitui = super.gitui.overrideAttrs (old: {
      #   version = "0.26.3";
      #   src = super.fetchurl {
      #     inherit (old.src) url;
      #     hash = "sha256-VahfSjzpdxK2GFdaqA88FepABNVU6ImWaZENf7T/bks=";
      #   };
      # });
    })
  ];

  users.users.danielgu = {
    description = "Daniel Gu";
    home = /Users/danielgu;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTwhApMK5w/Kym4Ffid+G0olp1SHN/HUr3Vbs4hfA3r danielgu@fwd-nixos"
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit self inputs; };
    users.danielgu = import ./home.nix;
    backupFileExtension = "bak";
  };

  environment.systemPackages = with pkgs; [
    # nushell
  ];
  environment.shells = [
    "/etc/profiles/per-user/danielgu/bin/fish"
    "${pkgs.nushell}/bin/nu"
  ];
  programs.fish.enable = true;

  services.openssh.enable = true;

  ids.gids.nixbld = 30000;

  system.stateVersion = 6;
  system.primaryUser = "danielgu";
}
