{
  pkgs,
  lib,
  self,
  ...
}:
rec {
  # Base
  programs.kitty = {
    enable = true;
    font = {
      name = if pkgs.stdenv.hostPlatform.isLinux then "JetBrains Mono Nerd Font" else "JetBrains Mono";
      size = 12;
    };
    settings = {
      disable_ligatures = "cursor";
      editor = lib.getExe self.packages.${pkgs.stdenv.system}.neovim;
      macos_option_as_alt = "left";

      # Catppuccin's kitty theme (applied via themeFile, see catppuccin.kitty
      # in home/common/default.nix) intentionally uses the same hex for most
      # normal/bright ANSI pairs, since it has one accent per hue rather than
      # separate bright variants. These overrides, written after the theme
      # include, lighten each bright slot ~25% toward white so they're
      # visibly distinct while keeping the same hue.
      color9 = "#f6a8be"; # bright red
      color10 = "#bceab9"; # bright green
      color11 = "#fbe9c3"; # bright yellow
      color12 = "#a7c7fb"; # bright blue
      color13 = "#f8d1ed"; # bright magenta
      color14 = "#afe9e0"; # bright cyan
    };
  };

  home.sessionVariables = {
    SHELL = "${pkgs.fish}/bin/fish";
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
    ZELLIJ_AUTO_EXIT = "true";
    _ZO_FZF_OPTS = "+e";
  };

  home.shellAliases = {
    glo = "git log --oneline";
    gs = "git status";
  };

  home.file.".claude/themes/catppuccin-mocha.json".source =
    ../extras/claude-code-catppuccin-mocha.json;

  # CLI programs
  home.shell.enableShellIntegration = true;
  programs = {
    bat.enable = true;
    btop.enable = true;
    carapace.enable = true;
    claude-code.enable = true;
    codex.enable = true;
    direnv.enable = true;
    eza.enable = true;
    fzf.enable = true;
    gitui.enable = true;
    keychain.enable = true;
    nix-index.enable = true;
    sioyek.enable = true;
    starship.enable = true;
    watson.enable = true;
    yazi.enable = true;
    zellij.enable = true;
    zoxide.enable = true;

    # Config
    btop.settings.vim_keys = true;
    direnv.nix-direnv.enable = true;
    gitui.keyConfig = ../extras/gitui_vim_keyconfig.ron;
    keychain.keys = [ "id_ed25519" ];
    sioyek.bindings = {
      "screen_down" = [
        "d"
        "<c-d>"
      ];
      "screen_up" = [
        "u"
        "<c-u>"
      ];
    };
    starship.settings = lib.recursiveUpdate (builtins.fromTOML (
      builtins.readFile ../extras/starship-nerdfont.toml
    )) { continuation_prompt = "┆ "; };
    yazi.shellWrapperName = "y";
    yazi.keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "<C-y>" ];
          run = ''shell 'xclip -selection clipboard -t image/png -i "$@"' --confirm'';
          desc = "Copy to system clipboard";
        }
      ];
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = home.shellAliases;
  };

  # Nushell config
  programs.nushell = {
    enable = true;
    extraConfig = builtins.readFile ../extras/config.nu;
    shellAliases = home.shellAliases;
    environmentVariables = home.sessionVariables;
  };
}
