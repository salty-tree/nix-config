{ pkgs, ... }:
{
  imports = [
    # ./i3
    ./rofi.nix
    ./wayland
    ./discord.nix
  ];

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override { enableWlrSupport = true; };
    settings.General.useGrimAdapter = true;
  };

  home.packages = with pkgs; [
    kdePackages.dolphin
    pulseaudio
  ];
}
