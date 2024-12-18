return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
            })

            vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0 win.position=left<cr>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle win.position=left<cr>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble quickfix toggle<cr>",
                { silent = true, noremap = true }
            )
        end
    },
}
