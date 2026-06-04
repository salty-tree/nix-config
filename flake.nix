{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";

    copyparty.url = "github:9001/copyparty";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    out_neovim.url = "path:./outputs/neovim";

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    copyparty.inputs.nixpkgs.follows = "nixpkgs";
    out_neovim.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      catppuccin,
      copyparty,
      out_neovim,
      zen-browser,
      ...
    }@inputs:
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
        in
        {
          inherit (out_neovim.packages.${system}) neovim neovim-min;
          rebuild = import ./rebuild-script.nix { inherit system pkgs inputs; };

          # homeConfigurations.danielgu = home-manager.lib.homeManagerConfiguration {
          #   inherit pkgs;
          #   modules = [
          #     ./hosts/macbook/home.nix
          #     catppuccin.homeManagerModules.catppuccin
          #   ];
          #   extraSpecialArgs = { inherit self inputs; };
          # };
        }
      );

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.default
          copyparty.nixosModules.default
          catppuccin.nixosModules.catppuccin
        ];
      };

      darwinConfigurations.dQw4w9WgXcQ = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/macbook/configuration.nix
          home-manager.darwinModules.default
        ];
      };

      nixosConfigurations.pzn = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/pzn/configuration.nix
          ./modules/minecraft
          home-manager.nixosModules.default
          catppuccin.nixosModules.catppuccin
        ];
      };
    };
}
