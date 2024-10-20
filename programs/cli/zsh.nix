{ pkgs, ...}: {

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            vim = "nvim";
            vi = "nvim";
            oldvim = "\vim";
        };

        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
                "git"
            ];
        };
    };
}
