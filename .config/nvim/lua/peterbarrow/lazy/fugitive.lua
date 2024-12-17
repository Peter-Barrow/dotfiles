return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gg", ":Git<cr>", { silent = true })
        vim.keymap.set("n", "<leader>ga", ":Git add %:p<cr><cr>", { silent = true })
        vim.keymap.set("n", "<leader>gd", ":Gdiff<cr>", { silent = true })
        vim.keymap.set("n", "<leader>ge", ":Gedit<cr>", { silent = true })
        vim.keymap.set("n", "<leader>gw", ":Gwrite<cr>", { silent = true })
        vim.keymap.set("n", "<leader>gf", ":Commits<cr>", { silent = true })
    end
}
