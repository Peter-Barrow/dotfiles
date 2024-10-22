{ pkgs, ... }: {
    imports = [
        ./zsh.nix
        ./tmux.nix
        ./starship.nix
        ./ghostty.nix
        ./btm.nix
    ];

}
