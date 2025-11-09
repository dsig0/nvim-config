{
  description = "Neovim config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    homeManagerModules.default = { config, pkgs, ... }: {
      programs.neovim.enable = true;

      # ✅ This makes your Neovim config appear at ~/.config/nvim
        home.file.".config/nvim" = {
    source = self;
    recursive = true;
  };
    };
}

