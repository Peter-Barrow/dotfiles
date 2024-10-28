{ lib, pkgs, inputs, ...}: {
    # nixpkgs.overlays = [inputs.neovim-nightly-overlay.overlay];

    imports = [
        ./programs/cli/cli.nix
        ./programs/editor/editor.nix
    ];

    # programs = {
    # };

    home = {
        packages = with pkgs; [
            home-manager
            hello
            oh-my-zsh
            luajitPackages.luarocks-nix
            gcc
            clang-tools
            pyenv
            direnv
            tectonic
        ];

        username = "peterbarrow";
        homeDirectory = "/home/peterbarrow";

        # WARN: Do not change
        stateVersion = "24.05";

    };
}
