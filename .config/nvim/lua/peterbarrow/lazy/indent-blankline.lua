return {
     "lukas-reineke/indent-blankline.nvim",
	 main = "ibl",
	 opts = {},

    config = function ()
        require("ibl").setup({
        -- scope = {
        --     enabled = true,
        --     show_start = false,
        --     show_end = false,
        --     injected_languages = true,
        --     highlight = { "Function", "Label" },
        --     -- priority = 500,
        --     -- include = {
        --     --      node_type = { ["*"] = { "*" } },
        --     -- },
        -- },
    })
    end
}
