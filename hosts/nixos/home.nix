{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../home/common
    ../../home/common/obs.nix
    ../../home/gui
    ../../home/linux
  ];

  home.username = "danielgu";
  home.homeDirectory = "/home/danielgu";

  home.packages = with pkgs; [
    # Misc
    porsmo
    godot_4
    libreoffice
    blender
    inkscape
    (callPackage ../../home/common/rebuild-script.nix {
      hostname = "nixos";
      system = "x86_64-linux";
    })
    balatro-mod-manager

    # Linux-specific
    inputs.zen-browser.packages.${stdenv.system}.default
    davinci-resolve
    wootility
    # wineWowPackages.stable
    # winetricks
  ];

  services.easyeffects.enable = true;

  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk2.extraConfig = "gtk-application-prefer-dark-theme=true";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
