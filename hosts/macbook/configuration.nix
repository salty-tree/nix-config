{
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # ../../modules/kanata
    ../common.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.overlays = [
    (self: super: {
      fish = super.fish.overrideAttrs (old: {
        doCheck = !super.stdenv.hostPlatform.isDarwin;
      });
      gitui = super.gitui.overrideAttrs (old: {
        version = "0.26.3";
        src = super.fetchurl {
          inherit (old.src) url;
          hash = "sha256-VahfSjzpdxK2GFdaqA88FepABNVU6ImWaZENf7T/bks=";
        };
      });
    })
  ];

  homebrew.enable = true;
  homebrew.casks = [
    "blackhole-2ch"
    "linearmouse"
    "android-platform-tools"
    "caffeine"
    "arduino-ide"
    "discord"

    # MS office
    "microsoft-word"
    "microsoft-powerpoint"
    "microsoft-excel"
    "microsoft-onenote"
    "microsoft-teams"
    "onedrive"

    # Misc
    "wechat"
    "steam"
    "blender"
    "obs"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    inter
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  users.users.danielgu = {
    description = "Daniel Gu";
    home = /Users/danielgu;
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = { inherit self inputs; };
    users.danielgu = import ./home.nix;
    backupFileExtension = "bak";
  };

  environment.systemPackages = with pkgs; [
    wget
    unzip
    nushell
  ];
  environment.shells = [
    "${pkgs.nushell}/bin/nu"
  ];

  services.openssh.enable = true;

  ids.gids.nixbld = 30000;

  system.stateVersion = 6;
  system.primaryUser = "danielgu";
}
