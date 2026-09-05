{ pkgs, lib, ... }:
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
  };

  vim.extraPackages = [
    pkgs.coq
  ];

  mnw.enable = true;
  mnw.providers.python3 = {
    enable = lib.mkForce true;
    extraPackages = ps: [ ps.pynvim ];
  };
}
