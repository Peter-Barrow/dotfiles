{ config, pkgs, lib, ... }:
let
    fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "${lib.strings.sanitizeDerivationName repo}";
        version = ref;
        src = builtins.fetchGit {
          url = "https://github.com/${repo}.git";
          ref = ref;
          rev = rev;
        };
      };
in {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.neovim;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
    
      plugins = with pkgs.vimPlugins; [
        # base distro
        # LazyVim
        conform-nvim
        # nvim-lint
        fugitive

        render-markdown-nvim
    
        # # theme
        # dracula-nvim
    
        # # UI
        # bufferline-nvim
        # gitsigns-nvim
        # edgy-nvim
        alpha-nvim
        toggleterm-nvim
        trouble-nvim
        lualine-nvim
        nvim-ufo
        no-neck-pain-nvim
        # which-key-nvim
        # nvim-web-devicons
        # mini-nvim
        # noice-nvim
        # nui-nvim
        # nvim-notify
        # nvim-lsp-notify
        # neo-tree-nvim
        # nvim-navic
        # dressing-nvim
        # aerial-nvim
    
        # # project management
        # project-nvim
        # neoconf-nvim
        # persistence-nvim
        persisted-nvim
    
        # # smart typing
        indent-blankline-nvim
        # guess-indent-nvim
        # vim-illuminate
    
        # # LSP
        nvim-lspconfig
        lsp-zero-nvim
        # rust-tools-nvim
        # crates-nvim
        # null-ls-nvim
        # nvim-lightbulb # lightbulb for quick actions
        # # nvim-code-action-menu # code action menu
        # neodev-nvim
        # SchemaStore-nvim # load known formats for json and yaml
        (fromGitHub 
            "fc38521ea4d9ec8dbd4c2819ba8126cea743943b"
            "master"
            "ray-x/lsp_signature.nvim"
        )
    
        # # cmp plugins
        nvim-cmp # completion plugin
        cmp-buffer # buffer completions
        cmp-path # path completions
        cmp_luasnip # snipper completions
        cmp-cmdline
        cmp-nvim-lsp # LSP completions
        (fromGitHub
            "031e6ba70b0ad5eee49fd2120ff7a2e325b17fa7"
            "main"
            "hrsh7th/cmp-nvim-lsp-signature-help"
        )
    
        # # snippets
        luasnip # snippet engine
        friendly-snippets # a bunch of snippets to use
        vim-snippets
    
        # search functionality
        plenary-nvim
        telescope-nvim
        # telescope-fzf-native-nvim
        # nvim-spectre
        # flash-nvim
    
        # # treesitter
        nvim-treesitter-context
        nvim-ts-autotag
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars
    
        # # comments
        # nvim-ts-context-commentstring
        todo-comments-nvim

        # languages
        (fromGitHub
            "d78c6df3aa8fe5e9af949149dc48184fbc945c04"
            "main"
            "MIBismuth/matlab.nvim"
        )
    
        # # leap
        # vim-repeat
        # leap-nvim
        # flit-nvim
    
        # # DAP
        # nvim-dap
        # nvim-dap-ui
        # nvim-dap-virtual-text
    
        # # neotest
        # neotest
        # neotest-rust
    
        lazy-nvim
        # vim-startuptime
        (fromGitHub "93958a83706dc010fef7e237c50602eda8a9e68b" "main" "ronisbr/nano-theme.nvim")
        (fromGitHub "d78c6df3aa8fe5e9af949149dc48184fbc945c04" "main" "MIBismuth/matlab.nvim")
      ];
    
      extraPackages = with pkgs; [
        gcc # needed for nvim-treesitter
    
        # # LazyVim defaults
        # stylua
        # shfmt
    
        # # Markdown extra
        # nodePackages.markdownlint-cli
        # marksman
    
        # # Docker extra
        # nodePackages.dockerfile-language-server-nodejs
        # hadolint
        # docker-compose-language-service
    
        # # JSON and YAML extras
        # nodePackages.vscode-json-languageserver
        # nodePackages.yaml-language-server
    
        # # Custom
        # editorconfig-checker
        # shellcheck

        lua-language-server
        # python-lsp-server
        (
            python3.withPackages (
                p: (with p; [
                    pylsp-mypy
                    python-lsp-server
                ])
            )
        )
        ruff
        clang
        nil
        nixpkgs-fmt
        texlab
        zls
        
      ];
    
      extraLuaConfig = ''
        vim.g.mapleader = "\\"

        require("lazy").setup({
          spec = {
            -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- -- import any extras modules here
            -- { import = "lazyvim.plugins.extras.dap.core" },
            -- { import = "lazyvim.plugins.extras.dap.nlua" },
            -- { import = "lazyvim.plugins.extras.ui.edgy" },
            -- { import = "lazyvim.plugins.extras.editor.aerial" },
            -- { import = "lazyvim.plugins.extras.editor.leap" },
            -- { import = "lazyvim.plugins.extras.editor.navic" },
            -- { import = "lazyvim.plugins.extras.lang.docker" },
            -- { import = "lazyvim.plugins.extras.lang.json" },
            -- { import = "lazyvim.plugins.extras.lang.markdown" },
            -- { import = "lazyvim.plugins.extras.lang.rust" },
            -- { import = "lazyvim.plugins.extras.lang.yaml" },
            -- { import = "lazyvim.plugins.extras.test.core" },
            -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
            -- import/override with your plugins
            { import = "plugins" },
          },
          defaults = {
            -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
            -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
            lazy = false,
            -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
            -- have outdated releases, which may break your Neovim install.
            version = false, -- always use the latest git commit
            -- version = "*", -- try installing the latest stable version for plugins that support semver
          },
          performance = {
            -- Used for NixOS
            reset_packpath = false,
            rtp = {
                reset = false,
                -- disable some rtp plugins
                disabled_plugins = {
                  "gzip",
                  -- "matchit",
                  -- "matchparen",
                  -- "netrwPlugin",
                  "tarPlugin",
                  "tohtml",
                  "tutor",
                  "zipPlugin",
                },
              }
            },
          dev = {
            path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
            patterns = {""},
          },
          install = {
            missing = false,
          },
        })

        require("config.keymaps")
        require("config.options")
      '';
    };
    
    xdg.configFile."nvim/lua" = {
      recursive = true;
      source = ./lua;
    };

}

