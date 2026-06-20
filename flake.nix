# flake.nix — zsh config
# nix run .          → sandboxed
# nix profile install → permanent (symlinks ~/.zshrc)
{
  description = "zsh config: oh-my-zsh + p10k + aliases";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in {
      packages = forAllSystems (pkgs: let
        config = pkgs.stdenv.mkDerivation {
          name = "zsh-moss-config";
          src = ./.;
          installPhase = ''
            mkdir -p $out
            cp .zshrc .p10k.zsh $out/
          '';
        };
      in {
        inherit config;
        default = pkgs.writeShellScriptBin "zsh-config" ''
          if echo "$0" | grep -q "/nix/var/nix/profiles/"; then
            rm -f ~/.zshrc
            ln -sf ${config}/.zshrc ~/.zshrc
            echo "🌿 zsh config → ~/.zshrc"
          else
            DIR=$(mktemp -d); trap 'rm -rf $DIR' EXIT
            ln -sf ${config}/.zshrc $DIR/.zshrc
            echo "zsh config at $DIR (sandboxed — source $DIR/.zshrc)"
          fi
        '';
      });
    };
}
