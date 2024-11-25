{ pkgs, ...}: {

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            vim = "nvim";
            vi = "nvim";
            oldvim = "\vim";
            matlab = "export LD_PRELOAD=/usr/lib64/libstdc++.so.6; export LD_LIBRARY_PATH=/usr/lib/dri/; $HOME/Applications/MATLAB-2024b/bin/matlab -nosplash -nodesktop";
            matlab-language-server = "node $HOME/Git/MATLAB-language-server/out/index.js";
            zvm = "$HOME/.zvm/self/zvm";

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
