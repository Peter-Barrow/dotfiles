return {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",

	-- build = ":TSUpdate | :TSEnable highlight",
	build = ":TSUpdate",
	-- cmd = { "TSUpdate", "TSEnable" },
	-- event = "BufReadPre",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			-- A list of parser names, or "all"
			ensure_installed = {
			    "markdown", "markdown-inline", "vimdoc", "c", "lua", "zig", "bash", "python", "matlab", "latex", "nix",
			    "bash", "zsh", "make",
			},
			-- ensure_installed = "all",
			-- ensure_installed = {},

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
			auto_install = false,

			indent = { enable = true },

			highlight = { enable = true },
		})

		require("treesitter-context").setup({
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		})
	end,
}
-- return {
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		opts = {
-- 			auto_install = false,
-- 			ensure_installed = {},
-- 		},
-- 	},
-- }
