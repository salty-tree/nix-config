{
  vim = {
    autocomplete.nvim-cmp.mappings = {
      complete = "<C-CR>";
    };
    # comments.comment-nvim.mappings = {};
    # git.gitsigns.mappings = {};
    utility.surround.setupOpts.keymaps = {
      normal = "s";
      normal_cur = "ss";
      normal_line = "S";
      normal_cur_line = "SS";
      visual = "s";
      visual_line = "S";
      delete = "ds";
      change = "cs";
      change_line = "cS";
    };

    # Other keymaps
    keymaps = let
      set = mode: key: action: {inherit mode key action;};
      set-lua = mode: key: action: {
        inherit mode key action;
        lua = true;
      };
    in [
      # Misc
      (set "" "H" "^")
      (set "" "L" "$")

      (set "i" "<C-Space>" "<Right><Esc>")
      (set "v" "<C-Space>" "<Esc>")
      (set "n" "<C-Space>" "<Cmd>w<CR>")

      (set "n" "<Esc>" "<Cmd>nohlsearch<CR>")
      (set "i" "<C-l>" "<Del>")
      (set "t" "<A-Esc>" "<C-\\><C-N>")

      # Window navigation
      (set "n" "<leader>g" "<Cmd>Neotree<CR>")
      (set "n" "<C-h>" "<C-w><C-h>")
      (set "n" "<C-j>" "<C-w><C-j>")
      (set "n" "<C-k>" "<C-w><C-k>")
      (set "n" "<C-l>" "<C-w><C-l>")

      # Diagnostics
      (set-lua "n" "gd" "vim.lsp.buf.definition")
      (set-lua "n" "[d" "vim.diagnostic.goto_prev")
      (set-lua "n" "]d" "vim.diagnostic.goto_next")
      (set-lua "n" "<leader>e" "vim.diagnostic.open_float")
      (set-lua "n" "<leader>q" "vim.diagnostic.setloclist")
    ];
  };
}
