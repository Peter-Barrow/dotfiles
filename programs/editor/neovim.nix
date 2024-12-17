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
    
    
      extraPackages = with pkgs; [
        # gcc # needed for nvim-treesitter
    
        # # # LazyVim defaults
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

        # lua-language-server
        # # python-lsp-server
        # (
        #     python3.withPackages (
        #         p: (with p; [
        #             pylsp-mypy
        #             python-lsp-server
        #         ])
        #     )
        # )
        # ruff
        # clang
        # nil
        # nixpkgs-fmt
        # texlab
        # # zls
        
      ];

    #   plugins = with pkgs.vimPlugins; [
    #     # lazy-nvim
    #   ];
    # 
    #   extraLuaConfig = 
    #     let plugins = with pkgs.vimPlugins; [
    #       # base distro
    #       # LazyVim
    #       conform-nvim
    #       fugitive

    #       render-markdown-nvim
    # 
    #       # theme
    #       lush-nvim
    # 
    #       # UI
    #       # gitsigns-nvim
    #       edgy-nvim
    #       alpha-nvim
    #       toggleterm-nvim
    #       trouble-nvim
    #       lualine-nvim
    #       nvim-ufo
    #       no-neck-pain-nvim
    # 
    #       # project management
    #       persisted-nvim
    # 
    #       # smart typing
    #       indent-blankline-nvim
    # 
    #       # LSP
    #       nvim-lspconfig
    #       lsp-zero-nvim
    #       (fromGitHub 
    #           "fc38521ea4d9ec8dbd4c2819ba8126cea743943b"
    #           "master"
    #           "ray-x/lsp_signature.nvim"
    #       )
    # 
    #       # # cmp plugins
    #       nvim-cmp # completion plugin
    #       cmp-buffer # buffer completions
    #       cmp-path # path completions
    #       cmp_luasnip # snipper completions
    #       cmp-cmdline
    #       cmp-nvim-lsp # LSP completions
    #       (fromGitHub
    #           "031e6ba70b0ad5eee49fd2120ff7a2e325b17fa7"
    #           "main"
    #           "hrsh7th/cmp-nvim-lsp-signature-help"
    #       )
    # 
    #       # # snippets
    #       luasnip # snippet engine
    #       friendly-snippets # a bunch of snippets to use
    #       vim-snippets
    # 
    #       # search functionality
    #       plenary-nvim
    #       telescope-nvim
    #       telescope-fzf-native-nvim
    # 
    #       # treesitter
    #       # nvim-treesitter.withAllGrammars
    #       nvim-treesitter
    #       nvim-treesitter-textobjects
    #       nvim-ts-autotag
    #       nvim-treesitter-context
    # 
    #       # # comments
    #       # nvim-ts-context-commentstring
    #       todo-comments-nvim

    #       # languages
    #       (fromGitHub
    #           "d78c6df3aa8fe5e9af949149dc48184fbc945c04"
    #           "main"
    #           "MIBismuth/matlab.nvim"
    #       )

    #       avante-nvim
    # 
    #       (fromGitHub "93958a83706dc010fef7e237c50602eda8a9e68b" "main" "ronisbr/nano-theme.nvim")
    #       (fromGitHub "d78c6df3aa8fe5e9af949149dc48184fbc945c04" "main" "MIBismuth/matlab.nvim")

    #       rose-pine
    #     ];

    #     mkEntryFromDrv = drv:
    #       if lib.isDerivation drv then
    #           {name = "${lib.getName drv}"; path = drv; }
    #       else
    #           drv;
    #     lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    #   in
    #   ''
    #     vim.g.mapleader = "\\"

    #     require("lazy").setup({
    #       defaults = {
    #         lazy = false,
    #         version = false, -- always use the latest git commit
    #       },
    #       dev = {
    #         -- path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
    #         path = "${lazyPath}",
    #         patterns = {""},
    #         fallback = true,
    #       },
    #       spec = {
    #         -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    #         -- -- import any extras modules here
    #         -- { import = "lazyvim.plugins.extras.dap.core" },
    #         -- { import = "lazyvim.plugins.extras.dap.nlua" },
    #         -- { import = "lazyvim.plugins.extras.ui.edgy" },
    #         -- { import = "lazyvim.plugins.extras.editor.aerial" },
    #         -- { import = "lazyvim.plugins.extras.editor.leap" },
    #         -- { import = "lazyvim.plugins.extras.editor.navic" },
    #         -- { import = "lazyvim.plugins.extras.lang.docker" },
    #         -- { import = "lazyvim.plugins.extras.lang.json" },
    #         -- { import = "lazyvim.plugins.extras.lang.markdown" },
    #         -- { import = "lazyvim.plugins.extras.lang.rust" },
    #         -- { import = "lazyvim.plugins.extras.lang.yaml" },
    #         -- { import = "lazyvim.plugins.extras.test.core" },
    #         -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    #         -- import/override with your plugins
    #         -- { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    #         { import = "plugins" },
    #         {"nvim-treesitter/nvim-treesitter", 
    #             opts = {
    #                 ensure_installed = {},
    #                 highlight = { enable = true },
    #                 indent = { enable = true },
    #                 } 
    #         },
    #       },
    #       performance = {
    #         -- Used for NixOS
    #         reset_packpath = false,
    #         rtp = {
    #             reset = false,
    #             -- disable some rtp plugins
    #             -- disabled_plugins = {
    #             --   "gzip",
    #             --   -- "matchit",
    #             --   -- "matchparen",
    #             --   -- "netrwPlugin",
    #             --   "tarPlugin",
    #             --   "tohtml",
    #             --   "tutor",
    #             --   "zipPlugin",
    #             -- },
    #           }
    #         },
    #       -- install = {
    #       --   missing = false,
    #       -- },
    #     })

    #     vim.cmd([[":TSEnable highlight"]])
    #     require("config.keymaps")
    #     require("config.options")
    #   '';
    # };

    # xdg.configFile."nvim/parser".source =
    #     let
    #         parsers = pkgs.symlinkJoin {
    #             name = "treesitter-parsers";
    #             # paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
    #             #   c
    #             #   lua
    #             #   python
    #             #   zig
    #             #   nix
    #             #   markdown
    #             #   markdown-inline
    #             # ])).dependencies;
    #             paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars).dependencies;
    #         };
    #     in
    #     "${parsers}/parser";
    # 
    # xdg.configFile."nvim/lua" = {
    #     recursive = true;
    #     source = ./lua;
    # };

    };
}
