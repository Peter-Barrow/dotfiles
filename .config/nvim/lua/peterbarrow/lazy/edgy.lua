return {
	-- edgy
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ue",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
            -- stylua: ignore
            { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
		},
		opts = function()
			local opts = {
				left = {
					"Trouble",
				},
				keys = {
					-- increase width
					["<c-Right>"] = function(win)
						win:resize("width", 2)
					end,
					-- decrease width
					["<c-Left>"] = function(win)
						win:resize("width", -2)
					end,
					-- increase height
					["<c-Up>"] = function(win)
						win:resize("height", 2)
					end,
					-- decrease height
					["<c-Down>"] = function(win)
						win:resize("height", -2)
					end,
				},
			}

			-- trouble
			for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
				opts[pos] = opts[pos] or {}
				table.insert(opts[pos], {
					ft = "trouble",
					filter = function(_buf, win)
						return vim.w[win].trouble
							and vim.w[win].trouble.position == pos
							and vim.w[win].trouble.type == "split"
							and vim.w[win].trouble.relative == "editor"
							and not vim.w[win].trouble_preview
					end,
				})
			end

			-- -- snacks terminal
			-- for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
			--     opts[pos] = opts[pos] or {}
			--     table.insert(opts[pos], {
			--         ft = "snacks_terminal",
			--         size = { height = 0.4 },
			--         title = "%{b:snacks_terminal.id}: %{b:term_title}",
			--         filter = function(_buf, win)
			--             return vim.w[win].snacks_win
			--                 and vim.w[win].snacks_win.position == pos
			--                 and vim.w[win].snacks_win.relative == "editor"
			--                 and not vim.w[win].trouble_preview
			--         end,
			--     })
			-- end
			return opts
		end,
	},

	-- use edgy's selection window
	{
		"nvim-telescope/telescope.nvim",
		optional = true,
		opts = {
			defaults = {
				get_selection_window = function()
					require("edgy").goto_main()
					return 0
				end,
			},
		},
	},

	-- -- prevent neo-tree from opening files in edgy windows
	-- {
	--     "nvim-neo-tree/neo-tree.nvim",
	--     optional = true,
	--     opts = function(_, opts)
	--         opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
	--             or { "terminal", "Trouble", "qf", "Outline", "trouble" }
	--         table.insert(opts.open_files_do_not_replace_types, "edgy")
	--     end,
	-- },

	-- -- Fix bufferline offsets when edgy is loaded
	-- {
	--     "akinsho/bufferline.nvim",
	--     optional = true,
	--     opts = function()
	--         local Offset = require("bufferline.offset")
	--         if not Offset.edgy then
	--             local get = Offset.get
	--             Offset.get = function()
	--                 if package.loaded.edgy then
	--                     local old_offset = get()
	--                     local layout = require("edgy.config").layout
	--                     local ret = { left = "", left_size = 0, right = "", right_size = 0 }
	--                     for _, pos in ipairs({ "left", "right" }) do
	--                         local sb = layout[pos]
	--                         local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
	--                         if sb and #sb.wins > 0 then
	--                             ret[pos] = old_offset[pos .. "_size"] > 0 and old_offset[pos]
	--                                 or pos == "left" and
	--                                 ("%#Bold#" .. title .. "%*" .. "%#BufferLineOffsetSeparator#│%*")
	--                                 or pos == "right" and
	--                                 ("%#BufferLineOffsetSeparator#│%*" .. "%#Bold#" .. title .. "%*")
	--                             ret[pos .. "_size"] = old_offset[pos .. "_size"] > 0 and old_offset[pos .. "_size"] or
	--                                 sb.bounds.width
	--                         end
	--                     end
	--                     ret.total_size = ret.left_size + ret.right_size
	--                     if ret.total_size > 0 then
	--                         return ret
	--                     end
	--                 end
	--                 return get()
	--             end
	--             Offset.edgy = true
	--         end
	--     end,
	-- },
}