{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nvf,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "aarch64-linux"
      ];
      eachSystem = func: (nixpkgs.lib.attrsets.genAttrs systems func);
    in
    {
      packages = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          neovim =
            full:
            nvf.lib.neovimConfiguration {
              inherit pkgs;
              extraSpecialArgs = {
                inherit system full;
              };
              modules = [ (import ../../modules/nvf) ];
            };
        in
        {
          neovim = (neovim true).neovim;
          neovim-min = (neovim false).neovim;
        }
      );
    };
}
