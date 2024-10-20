{ lib, pkgs, ...}: {
    imports = [
        ./programs/cli/cli.nix
    ];

    # programs = {
    # };

    home = {
        packages = with pkgs; [
            home-manager
            hello
            oh-my-zsh
        ];

        username = "peterbarrow";
        homeDirectory = "/home/peterbarrow";

        # WARN: Do not change
        stateVersion = "24.05";

    };
}
