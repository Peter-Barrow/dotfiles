return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip", -- Add LuaSnip back for snippet engine
	},

	-- use a release tag to download pre-built binaries
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- Custom keymap configuration
		keymap = {
			preset = "none", -- Start with no preset to build custom

			-- Completion menu navigation
			["<C-e>"] = { "hide", "fallback" },
			["<C-y>"] = { "select_and_accept" },
			["<CR>"] = { "accept", "fallback" }, -- Use Enter to accept

			-- Menu navigation
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "show", "select_next", "fallback" },
			["<Tab>"] = { "select_next", "fallback" }, -- Tab only for menu navigation
			["<S-Tab>"] = { "select_prev", "fallback" }, -- Shift-Tab only for menu navigation

			-- Snippet jumping with Ctrl-f/Ctrl-b
			["<C-f>"] = { "snippet_forward", "fallback" },
			["<C-b>"] = { "snippet_backward", "fallback" },

			-- Documentation scrolling
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			nerd_font_variant = "mono",
		},

		-- Enable automatic documentation popup with rounded border
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				window = {
					border = "rounded",
				},
			},
			menu = {
				border = "rounded",
			},
		},

		-- Enable signature help (replaces lsp_signature.nvim)
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},

		-- Configure snippet engine to use LuaSnip with custom keymaps
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},

		-- Default list of enabled providers
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			-- Optional: per-filetype configuration
			-- cmdline = { "path", "cmdline" },
		},

		-- Use Rust implementation for best performance
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
	opts_extend = { "sources.default" },
}
