return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'VonHeikemen/lsp-zero.nvim',
        -- "williamboman/mason.nvim",
        -- "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'ray-x/lsp_signature.nvim',
    },

    config = function()
        -- local lsp = require('lsp-zero').preset({})
        local lsp = require('lspconfig').util.default_config

        lsp.capabilities = vim.tbl_deep_extend(
            'force',
            lsp.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                vim.keymap.set('n', 'gsd', '<cmd>split | lua vim.lsp.buf.definition()<CR>', opts)
                vim.keymap.set('n', 'gvd', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
                vim.keymap.set("n", "<leader>s", "<cmd>Telescope lsp_document_symbols<CR>", opts)
                vim.keymap.set("n", "<leader>as", "<cmd>Telescope lsp_document_symbols<CR>", opts)
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
                vim.keymap.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", opts)
                vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
                vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
                vim.keymap.set("n", '<leader>cf', "<cmd>lua vim.lsp.buf.format()<cr>", opts)

                require('lsp_signature').on_attach({
                    bind = true,
                    hint_prefix = {
                        above = "↙ ", -- when the hint is on the line above the current line
                        current = "← ", -- when the hint is on the same line
                        below = "↖ " -- when the hint is on the line below the current line
                    },
                    handler_opts = {
                        border = "rounded",
                    },
                }, event.buf)
            end

        })

        -- FIX: get this working
        -- local lsp_zero = require('lsp-zero')
        -- lsp_zero.ui({
        --     float_border = 'rounded',
        --     sign_text = {
        --         error = '✘',
        --         warn = '▲',
        --         hint = '⚑',
        --         info = '»'
        --     },
        -- })

        -- lsp.set_server_config({
        --     capabilities = {
        --         textDocument = {
        --             foldingRange = {
        --                 dynamicRegistration = false,
        --                 lineFoldingOnly = true
        --             }
        --         }
        --     }
        -- })
        local cmp = require('cmp')
        cmp.setup({
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = { 'menu', 'abbr', 'kind' },

                -- here is where the change happens
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = 'λ',
                        luasnip = '⋗',
                        buffer = 'Ω',
                        path = '🖫',
                        nvim_lua = 'Π',
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                -- { name = 'nvim_lsp_signature_help' },
                { name = 'buffer',  keyword_length = 3 },
                { name = 'luasnip', keyword_length = 2 },
            },
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-u>'] = cmp.mapping.scroll_docs(4),
            }
        })

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        -- cmp.setup({
        --     snippet = {
        --         expand = function(args)
        --             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        --         end,
        --     },
        --     mapping = cmp.mapping.preset.insert({
        --         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        --         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        --         -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        --         ['<cr>'] = cmp.mapping.confirm({ select = true }),
        --         ["<C-Space>"] = cmp.mapping.complete(),
        --     }),
        --     sources = cmp.config.sources({
        --         { name = 'nvim_lsp' },
        --         { name = 'luasnip' }, -- For luasnip users.
        --     }, {
        --         { name = 'buffer' },
        --     })
        -- })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "Lua 5.1" },
                    diagnostics = {
                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                    }
                }
            }
        }

        lspconfig.clangd.setup({})

        lspconfig.nil_ls.setup {}

        lspconfig.pylsp.setup({
            capabilities = capabilities,
            single_file_support = true,
            settings = {
                pylsp = {
                    plugins = {
                        maxLineLength = 80,
                    },
                },
            },
        })

        lspconfig.ruff.setup({
            init_options = {
                settings = {
                },
            },
        })

        lspconfig.texlab.setup {}

        lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            cmd = { '/home/peterbarrow/.zvm/bin/zls' },
            settings = {
                zls = {
                    enable_inlay_hints = true,
                    enable_snippets = true,
                    warn_style = true,
                },
            },
        })

        lspconfig.matlab_ls.setup({
            cmd = { 'node', '/home/peterbarrow/Git/MATLAB-language-server/out/index.js', '--stdio' },
            single_file_support = true,
            settings = {
                MATLAB = {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    indexWorkspace = true,
                    installPath = '/home/peterbarrow/Applications/MATLAB-2024b/',
                    telemetry = false,
                    maxFileSizeForAnalysis = 0,
                }
            }
        })
    end
}
