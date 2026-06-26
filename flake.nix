{
  description = "config.nvim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };

          runtimeDeps = with pkgs; [
            tree-sitter
            curl
            fd
            gcc
            gh
            git
            glibc
            imagemagick
            lua-language-server
            nodejs
            openssl
            python3
            ripgrep
            stylua
            unzip
            util-linux
            wget
            zlib
            (vimPlugins.nvim-treesitter.withPlugins (p: [p.lua p.nix p.python]))
          ];

          binPath = pkgs.lib.makeBinPath runtimeDeps;

          nvim-config = pkgs.stdenv.mkDerivation {
            name = "nvim-config";
            src = ./.;
            installPhase = ''
              mkdir -p $out/nvim
              cp -r * $out/nvim/
            '';
          };
        in
        {
          default = pkgs.runCommand "nvim" { buildInputs = [ pkgs.makeWrapper ]; } ''
            mkdir -p $out/bin
            makeWrapper ${pkgs.neovim-unwrapped}/bin/nvim $out/bin/nvim \
              --prefix PATH : "${binPath}" \
              --set XDG_CONFIG_HOME "${nvim-config}"
          '';

          dev = pkgs.runCommand "nvim-dev" { buildInputs = [ pkgs.makeWrapper ]; } ''
            mkdir -p $out/bin
            makeWrapper ${pkgs.neovim-unwrapped}/bin/nvim $out/bin/nvim-dev \
              --prefix PATH : "${binPath}"
          '';
        }
      );
    };
}
