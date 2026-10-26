{ pkgs, ... }:
{

  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-calc ];
    settings.terminal = "kitty";
    theme = {
      "*".font = "monospace 12";
      window.height = "720px";
      window.border-radius = "10px";
    };
  };
  catppuccin.rofi.flavor = "macchiato";
}
