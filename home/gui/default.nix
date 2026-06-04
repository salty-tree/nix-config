{ pkgs, ... }:
{
  imports = [
    ./vscode.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    obsidian
    zotero
    anki-bin
    drawio

    osu-lazer-bin
    prismlauncher
  ];

  home.file = {
    ".ideavimrc".text = ''
      imap <C-Space> <Right><Esc>
      vmap <C-Space> <Esc>

      nmap H ^
      nmap L $

      imap <C-l> <Right><BS>

      nmap g<CR> :action ShowIntentionActions<CR>
      :command! R action Run
      :command! RC action RunClass
      :command! Fmt action ShowReformatFileDialog

      set ideajoin
    '';
  };

  xdg.configFile = {
    "zoomus.conf".source = ../extras/zoomus.conf;
    "ytmdesktop/style.css".source = ../extras/ytmdesktop-ctp.css;
  };
}
