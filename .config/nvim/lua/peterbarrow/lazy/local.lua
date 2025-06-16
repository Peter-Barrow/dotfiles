local local_plugins = {
	{
		"texpresso",
		dir = "~/Git/texpresso.vim",

		config = function()
			require("texpresso").texpresso_path = "~/Git/texpresso/build/texpresso"

			vim.keymap.set("n", "<leader>tx", "<cmd> TeXpresso % <cr>", { silent = true, noremap = true })
		end,
	},
}

return local_plugins
