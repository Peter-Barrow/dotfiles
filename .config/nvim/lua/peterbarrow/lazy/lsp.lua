return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp", -- Keep this for LSP capabilities
		"L3MON4D3/LuaSnip", -- Add back for snippet support
		"stevearc/conform.nvim", -- Ensure conform loads before LSP
	},

	opts = {
		inlay_hints = { enabled = true },
	},

	config = function()
		-- Setup LuaSnip
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Configure LSP handlers with rounded borders
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		-- Setup diagnostics configuration
		vim.diagnostic.config({
			virtual_text = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Setup capabilities with blink.cmp integration
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

		-- Add folding capabilities
		capabilities = vim.tbl_deep_extend("force", capabilities, {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		})

		-- LSP keymaps on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				-- Navigation
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				vim.keymap.set("n", "gsd", "<cmd>split | lua vim.lsp.buf.definition()<CR>", opts)
				vim.keymap.set("n", "gvd", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				-- Symbols and diagnostics
				vim.keymap.set("n", "<leader>s", "<cmd>Telescope lsp_document_symbols<CR>", opts)
				vim.keymap.set("n", "<leader>as", "<cmd>Telescope lsp_document_symbols<CR>", opts)
				vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)

				-- Code actions and refactoring
				vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				vim.keymap.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", opts)

				-- Formatting (manual only - conform handles auto-format)
				vim.keymap.set("n", "<leader>f", function()
					local ok, conform = pcall(require, "conform")
					if ok then
						conform.format({ async = false, lsp_fallback = true })
					else
						-- Fallback to LSP formatting if conform not available
						vim.lsp.buf.format()
					end
				end, opts)
				vim.keymap.set("n", "<leader>cf", function()
					local ok, conform = pcall(require, "conform")
					if ok then
						conform.format({ async = false, lsp_fallback = true })
					else
						-- Fallback to LSP formatting if conform not available
						vim.lsp.buf.format()
					end
				end, opts)
			end,
		})

		-- Setup Mason
		require("mason").setup()
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name) -- default handler
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			},
		})

		-- Individual LSP server configurations
		local lspconfig = require("lspconfig")

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "Lua 5.1" },
					diagnostics = {
						globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
					},
				},
			},
		})

		lspconfig.clangd.setup({
			capabilities = capabilities,
		})

		lspconfig.nil_ls.setup({
			capabilities = capabilities,
		})

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

		-- lspconfig.ruff.setup({
		-- 	capabilities = capabilities,
		-- 	init_options = {
		-- 		settings = {},
		-- 	},
		-- })

		lspconfig.texlab.setup({
			capabilities = capabilities,
		})

		lspconfig.zls.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
			cmd = { "/home/peterbarrow/.zvm/bin/zls" },
			settings = {
				zls = {
					enable_inlay_hints = true,
					enable_snippets = true,
					warn_style = true,
				},
			},
		})

		lspconfig.matlab_ls.setup({
			capabilities = capabilities,
			cmd = { "node", "/home/peterbarrow/Git/MATLAB-language-server/out/index.js", "--stdio" },
			single_file_support = true,
			settings = {
				MATLAB = {
					indexWorkspace = true,
					installPath = "/home/peterbarrow/Applications/MATLAB-2024b/",
					telemetry = false,
					maxFileSizeForAnalysis = 0,
				},
			},
		})
	end,
}
