{ ... }:
{
  vim = {
    autopairs.nvim-autopairs.setupOpts = {
      map_c_h = true;
      map_c_w = true;
    };

    dashboard.startify.bookmarks = [
      { n = "~/nix-config"; }
    ];
    dashboard.startify.changeToVCRoot = true;
    dashboard.startify.lists =
      let
        mkEntry = type: header: { inherit type header; };
      in
      [
        (mkEntry "dir" [ "MRU" ])
        (mkEntry "sessions" [ "Sessions" ])
        (mkEntry "bookmarks" [ "Bookmarks" ])
        (mkEntry "commands" [ "Commands" ])
      ];

    git.gitsigns.codeActions.enable = true;
    theme = {
      name = "catppuccin";
      style = "mocha";
    };

    statusline.lualine.globalStatus = false;
    statusline.lualine.refresh.statusline = 2000;

    lsp.formatOnSave = true;
    treesitter.highlight.enable = true;
    treesitter.indent.enable = true;

    # languages.rust.lsp.package = [ "rust-analyzer" ];
    # languages.rust.lsp.opts = ''
    #   ['rust-analyzer'] = {
    #     cargo = {allFeature = true},
    #     check = {
    #       command = "clippy",
    #     },
    #     checkOnSave = true,
    #     procMacro = {
    #       enable = true,
    #     },
    #     files = {
    #       watcher = "client",
    #     },
    #   },
    # '';

    lsp.servers.null-ls.capabilities.positionEncodings = "utf-8";
  };
}
