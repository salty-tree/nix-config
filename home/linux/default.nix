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
    # settings.General = {
    #   useGrimAdapter = true;
    #   disabledGrimWarning = true;
    # };
  };

  home.packages = with pkgs; [
    grim
    # kdePackages.dolphin
    pulseaudio
  ];
}
