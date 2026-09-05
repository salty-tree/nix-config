{ pkgs, ... }: {
  programs.vscodium = {
    enable = true;
    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          asvetliakov.vscode-neovim

          bbenoist.nix

          rocq-prover.vsrocq

          james-yu.latex-workshop
          ms-python.python
          ms-python.vscode-pylance

          ms-vsliveshare.vsliveshare
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "codespaces";
            publisher = "github";
            version = "1.17.1";
            sha256 = "1da29c214lyiqa7c9k92fgsr1qbi0sjq56ak90b5b9r2bi066njk";
          }
        ];
      userSettings = {
        "files.autoSave" = "off";
        "editor.lineNumbers" = "relative";
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "editor.fontLigatures" = true;
        "explorer.confirmDelete" = false;
        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };
        "workbench.colorTheme" = "Catppuccin Mocha";
      };
    };
  };
}
