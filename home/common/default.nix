{
  self,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./git.nix
    ./nixpkgs.nix
    # ./obs.nix
    ./terminal.nix
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin.enable = true;
  catppuccin.autoEnable = true;
  catppuccin.flavor = "mocha";

  # Basic packages
  home.packages = with pkgs; [
    ffmpeg
    alejandra
    scrcpy
    android-tools

    dust
    fd
    hyperfine
    mprocs
    ripgrep
    tokei
    self.packages.${stdenv.system}.neovim
    # self.packages.${stdenv.system}.rebuild
  ];

  # Dotfiles
  home.file = { };

  xdg.configFile = {
    "zellij/config.kdl".source = ../extras/zellij.kdl;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
