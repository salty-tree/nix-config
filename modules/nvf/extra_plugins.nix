{ pkgs, lib, ... }:
let
  vsrocqPlugin = pkgs.vimUtils.buildVimPlugin {
    pname = "vsrocq.nvim";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "tomtomjhj";
      repo = "vsrocq.nvim";
      rev = "dfa0e5a9e6b9fbd065fc6d9e1ec53e28f3dc11c5";
      hash = "sha256-2Hyzuc8ovNloUCrRn54EHN7DgKceNzSuMBVhOZtFHI8=";
    };
  };
in
{
  vim.extraPlugins = with pkgs.vimPlugins; {
    telescope-ui = {
      package = telescope-ui-select-nvim;
      setup = "require('telescope').load_extension('ui-select')";
      after = [ "telescope" ];
    };

    coqtail = {
      package = Coqtail;
      setup = "";
    };

    vsrocq = {
      package = vsrocqPlugin;
      setup = ''
        require("vsrocq").setup({
          vsrocq = {
            proof = { mode = "Continuous" },
            completion = {
              enable = true,
              algorithm = "StructuredSplitUnification",
            },
          },
        })
      '';
      after = [ "nvim-cmp" ];
    };
  };

  vim.globals = {
    loaded_coqtail = 1;
    coqtail_supported = 0;
  };

  mnw.enable = true;
  mnw.providers.python3 = {
    enable = lib.mkForce true;
    extraPackages = ps: [ ps.pynvim ];
  };
}
