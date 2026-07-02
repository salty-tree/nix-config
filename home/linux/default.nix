{ pkgs, ... }:
{
  imports = [
    # ./i3
    ./rofi.nix
    ./unity.nix
    ./wayland
    ./discord.nix
  ];

  # services.flameshot = {
  #   enable = true;
  #   package = pkgs.flameshot.override { enableWlrSupport = true; };
  #   # settings.General = {
  #   #   useGrimAdapter = true;
  #   #   disabledGrimWarning = true;
  #   # };
  # };

  home.packages = with pkgs; [
    grim
    # kdePackages.dolphin
    pulseaudio
    mpv
  ];

  xdg.configFile."fcitx5/conf/clipboard.conf".text = ''
    TriggerKey=Super+V
    Number of entries=50
  '';
}
