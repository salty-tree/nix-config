{ lib, pkgs, ... }:
{
  imports = [
    (lib.modules.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "danielgu" ])
  ];

  environment.systemPackages = with pkgs; [
    wget
    unzip
  ];

  time.timeZone = "America/Chicago";

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      # "https://cuda-maintainers.cachix.org"
    ];
    trusted-substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
    builders-use-substitutes = true;

    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
  };

  nix.optimise.automatic = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "firefox-esr-140-bin-unwrapped-140.17.0esr"
  ];

  nixpkgs.overlays = [
    (final: prev: {
      # https://github.com/NixOS/nixpkgs/pull/576762
      cloudflared = prev.cloudflared.overrideAttrs (old: {
        version = "2026.10.3";
        src = prev.fetchurl {
          inherit (old.src) url;
          hash = "sha256-aNKYxSKu9F/oQS4Mz48h/xKmrXaKppy8I+EOrGiKyMg=";
        };
      });
    })
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";
}
