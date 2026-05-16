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
      name = if pkgs.stdenv.isLinux then "JetBrains Mono Nerd Font" else "JetBrains Mono";
      size = 12;
    };
    settings = {
      disable_ligatures = "cursor";
      editor = lib.getExe self.packages.${pkgs.stdenv.system}.neovim;
      macos_option_as_alt = "left";
    };
  };

  home.sessionVariables = {
    SHELL = "nu";
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
    ZELLIJ_AUTO_EXIT = "true";
    _ZO_FZF_OPTS = "+e";
  };

  home.shellAliases = {
    glo = "git log --oneline";
    gs = "git status";
  };

  # CLI programs
  home.shell.enableShellIntegration = true;
  programs = {
    bat.enable = true;
    btop.enable = true;
    carapace.enable = true;
    codex.enable = true;
    direnv.enable = true;
    eza.enable = true;
    fzf.enable = true;
    gitui.enable = !pkgs.stdenv.hostPlatform.isDarwin;
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
