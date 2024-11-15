{ config, pkgs, lib, ... }:
    with lib;
    # let cfg = config.modules.editors.emacs;
    let cfg = config.programs.emacs;
        emacs = with pkgs; ( emacsPackagesFor
            emacs-pgtk
            ).emacsWithPackages (epkgs: with epkgs; [
                treesit-grammars.with-all-grammars
                vterm
                mu4e
                ]
            );
    in {
        # options.modules.editors.emacs = {
        #     enable = mkBoolOpt false;
        # };

        config = {

            home.packages = with pkgs; [
                # (mkLauncherEntry "Emacs (Debug Mode)" {
                #   description = "Start Emacs in debug mode";
                #   icon = "emacs";
                #   exec = "${emacs}/bin/emacs --debug-init";
                # })

                ## Emacs itself
                binutils            # native-comp needs 'as', provided by this
                emacs               # HEAD + native-comp

                ## Doom dependencies
                git
                ripgrep
                gnutls              # for TLS connectivity

                ## Optional dependencies
                fd                  # faster projectile indexing
                imagemagick         # for image-dired
                # (mkIf (config.programs.gnupg.agent.enable)
                #   pinentry-emacs)   # in-emacs gnupg prompts
                zstd                # for undo-fu-session/undo-tree compression

                ## Module dependencies
                # :email mu4e
                mu
                # unstable.isync
                # :checkers spell
                # (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
                # :tools editorconfig
                editorconfig-core-c # per-project style config
                # :tools lookup & :lang org +roam
                sqlite
                # :lang latex & :lang org (latex previews)
                texlive.combined.scheme-medium
                # :lang beancount
                beancount
                fava
                # :lang nix
                age
            ];
            # environment.variables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

            home.file = {
                ".config/doom/config.el".source = ./doom/config.el;
                ".config/doom/init.el".source = ./doom/init.el;
                ".config/doom/packages.el".source = ./doom/packages.el;
            };
    };
}
