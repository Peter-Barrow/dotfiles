{ pkgs, ... }: {
    imports = [
        ./zsh.nix
        ./tmux.nix
        ./starship.nix
        ./btm.nix
#        ./tectonic.nix
    ];

}
