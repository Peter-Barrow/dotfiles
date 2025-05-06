{ lib, pkgs, inputs, ...}: {

    imports = [
        ./programs/cli/cli.nix
        ./programs/editor/editor.nix
        ./ui/gtk.nix
        # ./programs/zotero.nix
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
            zotero
            poetry

            emacs
            # fd
            # imagemagick
            # zstd
            # gnutls
            # sqlite
        ];

        sessionPath = [
            "$HOME/.local/bin"
            "$XDG_CONFIG_HOME/emacs/bin"
            "$HOME/.zvm/"
            "$HOME/.zvm/bin"
        ];

        username = "peterbarrow";
        homeDirectory = "/home/peterbarrow";

        # WARN: Do not change
        stateVersion = "24.05";

    };
}
