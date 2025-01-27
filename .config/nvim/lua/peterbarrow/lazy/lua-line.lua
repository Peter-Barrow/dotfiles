return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					-- theme = "catppuccin",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						--statusline = { "neo-tree" },
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						-- tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							icon = "",
							separator = { left = "", right = "" },
							color = {
								fg = "#1e1e2e",
								bg = "#b4befe",
							},
						},
					},
					lualine_b = {
						{
							"diff",
						},
						{
							"branch",
							icon = "",
							separator = { left = "", right = "" },
							color = {
								fg = "#1e1e2e",
								bg = "#7d83ac",
							},
						},
					},
					lualine_c = {
						{
							"diagnostics",
							separator = { left = "", right = "" },
							color = {
								bg = "#45475a",
							},
						},
						{
							"filename",
						},
					},
					-- lualine_x = { "filesize" },
					lualine_x = { "tabs" },
					lualine_y = {
						{
							"filetype",
							icons_enabled = false,
							color = {
								fg = "#1e1e2e",
								bg = "#eba0ac",
							},
						},
					},
					lualine_z = {
						{
							"location",
							icon = "",
							color = {
								fg = "#1e1e2e",
								bg = "#f2cdcd",
							},
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				-- tabline = {},
				winbar = {},
				inactive_winbar = {},
				--extensions = { "neo-tree", "lazy" },
			})
		end,
	},
}
