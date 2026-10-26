{ pkgs, ... }:
{
  imports = [
    # ./i3
    ./rofi.nix
    ./unity.nix
    ./wayland
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

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-enable-primary-paste = false;
      color-scheme = "prefer-dark";
    };
  };

  catppuccin.cursors.enable = true;
  catppuccin.cursors.accent = "lavender";
  home.pointerCursor.enable = true;
  home.pointerCursor.hyprcursor.enable = true;
}
